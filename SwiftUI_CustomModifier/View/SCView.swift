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

    init(viewRouter: ViewRouter, action: @escaping (Bool) -> Void) {
        self.action = action
        self.viewRouter = viewRouter
    }

    var body: some View {
        GeometryReader { geometry in
            ScrollView(showsIndicators: false) {

                VStack(spacing: 0) {

                    self.viewRouter.isAnimating()
                        .frame(maxWidth: .infinity)
                        .frame(height: self.heightOffset)
                        .offset(y: -self.viewRouter.designModel.offset == 0 ? self.heightOffset/2 : 0)

                    GeometryReader { insideProxy in
                        TextViews(viewRouter: self.viewRouter)
                            .background(Color.green)
                            .preference(key: ScrollOffsetPreferenceKey.self,
                                        value: [self.calculateContentOffset(fromOutsideProxy: geometry,
                                                                            insideProxy: insideProxy)])
                            .offset(y: self.viewRouter.designModel.offset == 0 ? -self.heightOffset : 0)
                    }
                    .frame(height: self.heightOffset*CGFloat(self.viewRouter.designModel.texIndex.count) - self.heightOffset)
                }
            }
            .gesture(DragGesture()
            .onChanged({ value in
                value.translation.height > 0 ? self.action(true) : self.action(false)
                self.viewRouter.designModel.offset = value.translation.height > 0 ? 1 : 0
            }))

                .onPreferenceChange(ScrollOffsetPreferenceKey.self) { _ in

                    self.viewRouter.setupProcessingTimr(1.0, action: self.action)
            }

            .onAppear {
                self.action(false)
            }
        }
    }

    private func calculateContentOffset(fromOutsideProxy outsideProxy: GeometryProxy, insideProxy: GeometryProxy) -> CGFloat {
        return outsideProxy.frame(in: .global).minY - insideProxy.frame(in: .global).minY
    }
}
