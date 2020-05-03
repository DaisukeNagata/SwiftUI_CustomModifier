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

    @State private var heightOffset: CGFloat = 200
    @State private var texIndex = [Text("Hello"),Text("World")]
    @Binding var contentOffset: CGFloat
    
    @ObservedObject var viewRouter: ViewRouter

    init(viewRouter: ViewRouter, contentOffset: Binding<CGFloat>, action: @escaping (Bool) -> Void) {
        self.action = action
        self.viewRouter = viewRouter
        self._contentOffset = contentOffset
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
                        TextViews(desDsign: self.texIndex)
                            .background(Color.green)
                            .preference(key: ScrollOffsetPreferenceKey.self, value: [self.calculateContentOffset(fromOutsideProxy: geometry, insideProxy: insideProxy)])
                            .offset(y: self.viewRouter.designModel.offset == 0 ? -self.heightOffset : 0)
                    }
                    .frame(height: UIScreen.main.bounds.height*CGFloat(self.texIndex.count) - self.heightOffset)
                }
            }
            .gesture(DragGesture()
            .onChanged({ value in
                value.translation.height > 0 ? self.action(true) : self.action(false)
                self.viewRouter.designModel.offset = value.translation.height > 0 ? 1 : 0
            }))
                .onPreferenceChange(ScrollOffsetPreferenceKey.self) { _ in
                    self.viewRouter.setupProcessingTimr(3.0, action: self.action)
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
