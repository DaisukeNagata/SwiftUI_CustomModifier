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

    @ObservedObject var viewModel: ViewModel

    init(viewRouter: ViewModel, action: @escaping (Bool) -> Void) {
        self.action = action
        self.viewModel = viewRouter
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                List {
                    ForEach(viewModel.designModel.texIndex.indices, id: \.self) { v in
                       Text(self.viewModel.designModel.texIndex[v])
                            .frame(maxWidth: .infinity,alignment: .center)
                            .frame(height: 100)
                            .onTapGesture {
                                self.viewModel.designModel.texIndex.remove(at: v)
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
            self.viewModel.isAnimating()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .edgesIgnoringSafeArea(.all)
        }
    }
}
