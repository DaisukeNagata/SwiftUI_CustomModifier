//
//  NavigationModifier.swift
//  SwiftUI_CustomModifier
//
//  Created by 永田大祐 on 2020/04/03.
//  Copyright © 2020 永田大祐. All rights reserved.
//

import SwiftUI

struct NavigationModifier: ViewModifier {

    @State var tag : Int?
    @State var view: AnyView?
    var viewModel: ViewModel

    func body(content: Content) -> some View {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = viewModel.designModel.backgroundextColor
        appearance.titleTextAttributes = [.foregroundColor: viewModel.designModel.titleTextTextColor]
        appearance.largeTitleTextAttributes = [.foregroundColor: viewModel.designModel.largeTitleTextColor]

        if viewModel.designModel.backgroundextColor == UIColor.clear {
            UINavigationBar.appearance().setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            UINavigationBar.appearance().shadowImage = UIImage()
        } else {
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }

        return
            NavigationView {
                VStack {
                    Color.clear
                        .navigationBarItems(leading:
                            Button(action: {
                                withAnimation { viewModel.designModel.flg.toggle()}
                            }) {
                                SetDesgin(ima: Image(systemName: "person.crop.circle") )
                            }, trailing:

                            Button(action: {
                                tag = 1
                            }) {
                                SetDesgin(ima: Image(systemName: "arrow.right") )
                        }
                    )
                    NavigationLink(destination: AnyView(ListView( viewRouter: self.viewModel, action: { flg in
                            if flg {
                                viewModel.reModel.spinner.isAnimating = flg
                                // This is reload Time Example
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [self] in
                                    0 == viewModel.designModel.texIndex.count % 2 ?
                                    viewModel.designModel.texIndex.append("Hello") :
                                    viewModel.designModel.texIndex.append("World")
                                    viewModel.action?()
                                }
                            }
                    })
                    ), tag: tag ?? 0, selection: $tag) {
                        EmptyView()
                    }
                    .navigationBarTitle("\(viewModel.designModel.titleText)", displayMode: viewModel.naviModel.mode)
                }
            }
            .navigationViewStyle(StackNavigationViewStyle())
    }
}


private struct SetDesgin: View {
    var ima: Image
    var body: some View {
        return
            ima
            .resizable()
            .renderingMode(.original)
            .frame(width: 32.0, height: 32.0)
    }
}
