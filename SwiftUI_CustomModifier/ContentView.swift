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
                    
                    if self.selection == 1 {
                        Button(action: {
                            print("タップされました")
                        }) {
                            ZStack {
                                self.border(tex: "border", lineWidth: 2.0, CGPoint(x: 100, y: 0), CGPoint(x: 100, y: 100), Color.yellow)
                                self.border(tex: "", lineWidth: 2.0, CGPoint(x: 0, y: 0), CGPoint(x: 0, y: 100), Color.black)
                            }
                            .frame(width: 100, height: 100, alignment: .center)
                        }
                    }
    
                    if self.selection == 2 {
                        Text("Hello, World!")
                    }
                }
                ZStack {
                    self.border(tex: "", lineWidth: 2.0, CGPoint(x: 0, y: 0), CGPoint(x: geometry.size.width, y: 0), Color.red)
                        .frame(width: geometry.size.width, height: geometry.size.height/10).background(Color.clear)
                    HStack {
                        self.modifier(TabModifier(selection:  self.$selection, viewRouter: self.viewRouter, tag: 1))
                        self.modifier(TabModifier(selection:  self.$selection, viewRouter: self.viewRouter, tag: 2))
                        self.modifier(TabModifier(selection:  self.$selection, viewRouter: self.viewRouter, tag: 3))
                        self.modifier(TabModifier(selection:  self.$selection, viewRouter: self.viewRouter, tag: 4))
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height/10)
                }
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
