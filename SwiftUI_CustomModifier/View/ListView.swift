//
//  ListView.swift
//  SwiftUI_CustomModifier
//
//  Created by 永田大祐 on 2020/10/14.
//  Copyright © 2020 永田大祐. All rights reserved.
//

import SwiftUI

struct ListView: View {

    var action: (_ index: Bool) -> Void

    @ObservedObject var viewRouter: ViewRouter

    init(viewRouter: ViewRouter, action: @escaping (Bool) -> Void) {
        self.action = action
        self.viewRouter = viewRouter
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                List {
                    ForEach(viewRouter.designModel.texIndex.indices, id: \.self) { v in
                       Text(self.viewRouter.designModel.texIndex[v])
                            .frame(maxWidth: .infinity,alignment: .center)
                            .frame(height: 100)
                            .onTapGesture {
                                self.viewRouter.designModel.texIndex.remove(at: v)
                        }
                    }
                }
                .gesture(DragGesture()
                            .onChanged({ value in
                                // Example
                                self.action(true)
                            }))
                .onPreferenceChange(ScrollOffsetPreferenceKey.self) { key in
                    // Example
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        self.action(false)
                    }
                }
            }
            self.viewRouter.isAnimating()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .edgesIgnoringSafeArea(.all)
        }
    }
}
