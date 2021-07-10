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
    var viewRouter: ViewModel

    func body(content: Content) -> some View {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = viewRouter.designModel.backgroundextColor
        appearance.titleTextAttributes = [.foregroundColor: viewRouter.designModel.titleTextTextColor]
        appearance.largeTitleTextAttributes = [.foregroundColor: viewRouter.designModel.largeTitleTextColor]

        if viewRouter.designModel.backgroundextColor == UIColor.clear {
            UINavigationBar.appearance().setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            UINavigationBar.appearance().shadowImage = UIImage()
        } else {
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }

        return
            NavigationView {
                VStack {
                    Text("")
                        .navigationBarItems(leading:
                            Button(action: {
                                withAnimation { self.viewRouter.designModel.flg.toggle()}
                            }) {
                                SetDesgin(ima: Image(systemName: "person.crop.circle") )
                            }, trailing:

                            Button(action: {
                                self.tag = 1
                            }) {
                                SetDesgin(ima: Image(systemName: "arrow.right") )
                        }
                    )
                    NavigationLink(destination: AnyView(ListView( viewRouter: self.viewRouter, action: { flg in
                            if flg {
                                
                                0 == self.viewRouter.designModel.texIndex.count % 2 ?
                                    self.viewRouter.designModel.texIndex.append("Hello") :
                                    self.viewRouter.designModel.texIndex.append("World")
                            }
                        self.viewRouter.reModel.spinner.isAnimating = flg
                    })
                    ), tag: self.tag ?? 0, selection: $tag) {
                        EmptyView()
                    }
                    .navigationBarTitle("\(self.viewRouter.designModel.titleText)", displayMode: viewRouter.naviModel.mode)
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
