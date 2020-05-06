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
    @State var view: AnyView
    @ObservedObject var viewRouter: ViewRouter

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
                                withAnimation {
                                    self.viewRouter.designModel.flg.toggle()
                                }
                            }) {
                                Image(systemName: "person.crop.circle")
                                    .resizable()
                                    .renderingMode(.original)
                                    .frame(width: 32.0, height: 32.0)
                            },
                                            trailing:
                            Button(action: {
                                self.tag = 1
                            }) {
                                Image(systemName: "arrow.right")
                                    .resizable()
                                    .renderingMode(.original)
                                    .frame(width: 32.0, height: 32.0)
                        })
                    NavigationLink(destination: AnyView(SCView( viewRouter: self.viewRouter, action: { flg in
                        if !flg {
                            if self.viewRouter.reModel.spinner.isAnimating {
                                self.viewRouter.reModel.spinner.isAnimating = flg

                                defer {
                                    self.viewRouter.reModel.id = 0
                                }

                                guard  self.viewRouter.reModel.id == 0 else {
                                    return
                                }
                                0 == self.viewRouter.designModel.texIndex.count % 2 ?
                                    self.viewRouter.designModel.texIndex.insert(contentsOf: [Text("Hello")], at: 0) :
                                    self.viewRouter.designModel.texIndex.insert(contentsOf: [Text("Word")], at: 0)
                            }
                        }
                        self.viewRouter.reModel.spinner.isAnimating = flg
                    })
                    ), tag: self.tag ?? 0, selection: $tag) {
                        EmptyView()
                    }
                    .navigationBarTitle("\(self.viewRouter.designModel.titleText)", displayMode: viewRouter.naviModel.mode)
                }
        }
    }
}

struct NavigationModifier_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
