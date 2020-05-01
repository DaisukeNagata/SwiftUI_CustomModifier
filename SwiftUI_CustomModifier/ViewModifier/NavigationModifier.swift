//
//  NavigationModifier.swift
//  SwiftUI_CustomModifier
//
//  Created by 永田大祐 on 2020/04/03.
//  Copyright © 2020 永田大祐. All rights reserved.
//

import SwiftUI

enum BoderPos: String {
    case top,left,right,bottom
}

struct NavigationModifier: ViewModifier {

    @State var tag : Int?
    @State var view: AnyView
    @State var titleText  : String
    @State var backgroundextColor : UIColor
    @State var titleTextTextColor : UIColor
    @State var largeTitleTextColor: UIColor
    @ObservedObject var viewRouter: ViewRouter
    @State var mode: NavigationBarItem.TitleDisplayMode

    func body(content: Content) -> some View {

        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = backgroundextColor
        appearance.titleTextAttributes = [.foregroundColor: titleTextTextColor]
        appearance.largeTitleTextAttributes = [.foregroundColor: largeTitleTextColor]

        if backgroundextColor == UIColor.clear {
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
                                    self.viewRouter.flg.toggle()
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
                    NavigationLink(destination: AnyView(SegueView()), tag: self.tag ?? 0, selection: $tag) {
                        EmptyView()
                    }
                    .navigationBarTitle("\(titleText)", displayMode: mode)
                }
        }
    }
}

struct NavigationModifier_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
