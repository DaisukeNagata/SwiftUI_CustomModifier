//
//  NavigationModifier.swift
//  SwiftUI_CustomModifier
//
//  Created by 永田大祐 on 2020/04/03.
//  Copyright © 2020 永田大祐. All rights reserved.
//

import SwiftUI

struct NavigationModifier: ViewModifier {

    @State var view: AnyView
    @State var titleText : String
    @State var backgroundextColor : UIColor
    @State var titleTextTextColor : UIColor
    @State var largeTitleTextColor: UIColor
    @State var mode: NavigationBarItem.TitleDisplayMode

    func body(content: Content) -> some View {

        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = backgroundextColor
        appearance.titleTextAttributes = [.foregroundColor: titleTextTextColor]
        appearance.largeTitleTextAttributes = [.foregroundColor: largeTitleTextColor]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance

        return
            NavigationView {
                VStack {
                    
                    Text("")
                        .navigationBarItems(trailing:
                            Button(action: {
                                
                            }) {
                                Image(systemName: "person.crop.circle")
                                    .resizable()
                                    .renderingMode(.original)
                                    .frame(width: 32.0, height: 32.0)
                        })
                        .navigationBarTitle("\(titleText)", displayMode: mode)
                }
        }
    }
}
