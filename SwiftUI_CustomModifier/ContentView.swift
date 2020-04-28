//
//  ContentView.swift
//  SwiftUI_CustomModifier
//
//  Created by 永田大祐 on 2020/04/03.
//  Copyright © 2020 永田大祐. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    @State private var selection: Int = 1
    @ObservedObject var viewRouter = ViewRouter()

    var body: some View {
        GeometryReader { geometry in
            VStack {
                ZStack {
                    self.modifier(NavigationModifier(view: AnyView(self),
                                                     titleText: "Welcome",
                                                     backgroundextColor: UIColor.clear,
                                                     titleTextTextColor: UIColor.black, // inline
                                                     largeTitleTextColor: UIColor.yellow, // large
                                                     viewRouter: self.viewRouter,
                                                     mode: .inline))
                    
                    if self.selection == 2 {
                        Text("Hello, World!")
                    }
                }
                HStack {
                    self.modifier(TabModifier(selection:  self.$selection, viewRouter: self.viewRouter, tag: 1))
                    self.modifier(TabModifier(selection:  self.$selection, viewRouter: self.viewRouter, tag: 2))
                    self.modifier(TabModifier(selection:  self.$selection, viewRouter: self.viewRouter, tag: 3))
                    self.modifier(TabModifier(selection:  self.$selection, viewRouter: self.viewRouter, tag: 4))
                }
                .boder(rectMove: CGRect(x: 0, y: 0, width: 0, height: 1), rectLine: CGRect(x: geometry.size.width, y: 0, width: geometry.size.width, height: 1))
                .frame(width: geometry.size.width, height: geometry.size.height/10)
                .background(Color.black)
            }
            self.modifier(AlertModifer(view:  AnyView(AlertChoiceView(viewRouter: self.viewRouter))))
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
