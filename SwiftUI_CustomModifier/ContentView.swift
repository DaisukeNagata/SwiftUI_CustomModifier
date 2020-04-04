//
//  ContentView.swift
//  SwiftUI_CustomModifier
//
//  Created by 永田大祐 on 2020/04/03.
//  Copyright © 2020 永田大祐. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    @ObservedObject var viewRouter = ViewRouter()
    @State private var selection: Int = 1
    @State private var aa = AlertChoiceView()
    var body: some View {
        GeometryReader { geometry in
            VStack {
                ZStack {
                    self.modifier(NavigationModifier(view: AnyView(self),
                                                     titleText: "Welcome",
                                                     backgroundextColor: UIColor.green,
                                                     titleTextTextColor: UIColor.red, // inline
                                                     largeTitleTextColor: UIColor.blue, // large
                                                     mode: .inline))
                    
                    if self.selection == 2 {
                        Text("Hello, World!")
                            .onTapGesture {
                                self.viewRouter.flg.toggle()
                        }
                    }
                }
                HStack {
                    self.modifier(TabModifier(selection:  self.$selection, viewRouter: self.viewRouter, tag: 1))
                    self.modifier(TabModifier(selection:  self.$selection,viewRouter: self.viewRouter, tag: 2))
                    self.modifier(TabModifier(selection:  self.$selection, viewRouter: self.viewRouter, tag: 3))
                    self.modifier(TabModifier(selection:  self.$selection,viewRouter: self.viewRouter, tag: 4))
                }
                .frame(width: geometry.size.width, height: geometry.size.height/10)
            }
            self.modifier(AlertModifer(view:  AnyView(self.aa)))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
