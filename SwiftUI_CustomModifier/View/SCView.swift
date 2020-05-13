//
//  SegueView.swift
//  SwiftUI_CustomModifier
//
//  Created by 永田大祐 on 2020/04/06.
//  Copyright © 2020 永田大祐. All rights reserved.
//

import SwiftUI

struct SCView: View {

    var action: (_ index: Bool) -> Void

    @State private var heightOffset: CGFloat = 100

    @ObservedObject var viewRouter: ViewRouter
    var t: TextViews?

    init(viewRouter: ViewRouter, action: @escaping (Bool) -> Void) {
        self.action = action
        self.viewRouter = viewRouter
        self.t = TextViews(viewRouter: self.viewRouter)
    }

    var body: some View {
        GeometryReader { geometry in
            ScrollView(showsIndicators: false) {

                VStack(spacing: 0) {

                    self.viewRouter.isAnimating().frame(height: self.heightOffset)

                    GeometryReader { insideProxy in
                        self.t
                            .preference(key: ScrollOffsetPreferenceKey.self, value: [self.calculateContentOffset(fromOutsideProxy: geometry, insideProxy: insideProxy)])
                            .offset(y: self.viewRouter.designModel.offset == 0 ? -self.heightOffset : 0)
                    }
                    .frame(height: self.heightOffset*CGFloat(self.viewRouter.designModel.texIndex.count) - self.heightOffset)
                }
            }
            .gesture(DragGesture()
            .onChanged({ value in
                self.action(true)
                self.viewRouter.designModel.offset = value.translation.height
            }))

                .onPreferenceChange(ScrollOffsetPreferenceKey.self) { _ in
                    self.viewRouter.setupProcessingTimr(1.0, action: self.action)
            }
        }
    }

    private func calculateContentOffset(fromOutsideProxy outsideProxy: GeometryProxy, insideProxy: GeometryProxy) -> CGFloat {
        return outsideProxy.frame(in: .global).minY - insideProxy.frame(in: .global).minY
    }
}
