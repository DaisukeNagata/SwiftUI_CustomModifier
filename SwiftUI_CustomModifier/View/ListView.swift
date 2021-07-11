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
    @State var flg = false
    @ObservedObject var viewModel: ViewModel

    init(viewRouter: ViewModel, action: @escaping (Bool) -> Void) {
        self.action = action
        viewModel = viewRouter
        refreshBind()
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                List {
                    ForEach(viewModel.designModel.texIndex.indices, id: \.self) { v in
                        Text(viewModel.designModel.texIndex[v])
                            .frame(maxWidth: .infinity,alignment: .center)
                            .frame(height: 100)
                            .background(changeColor(v: v))
                            .onTapGesture {
                                viewModel.designModel.texIndex.remove(at: v)
                            }
                    }
                }
                .gesture(DragGesture()
                            .onChanged({ value in
                    // Example
                    if !viewModel.reModel.spinner.isAnimating {
                        self.action(true)
                    }
                }))
            }
            viewModel.isAnimating()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .edgesIgnoringSafeArea(.all)
        }
    }

    private func changeColor(v: Int) -> Color {
        viewModel.designModel.texIndex[v] == "Hello" ? .green : .orange
    }

    private func refreshBind() {
        viewModel.action = {
            viewModel.reModel.spinner.isAnimating = false
        }
    }
}
