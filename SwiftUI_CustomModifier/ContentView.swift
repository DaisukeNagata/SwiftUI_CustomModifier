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

                    self.naviBoarder(modi:
                        NavigationModifier(view: AnyView(self),
                                                              titleText: "Welcome",
                                                              backgroundextColor: UIColor.green,
                                                              titleTextTextColor: UIColor.black, // inline
                                                              largeTitleTextColor: UIColor.yellow, // large
                                                              viewRouter: self.viewRouter),
                                                              lineWidth: 2,
                                                              CGPoint(x: 0, y: self.viewRouter.mode == .inline ? 44 : 95),
                                                              CGPoint(x: geometry.size.width, y: self.viewRouter.mode == .inline ? 44 : 95),
                                                              Color.purple)
                        .onAppear {
                            self.viewRouter.mode = .large
                    }
                        
                    
                    if self.selection == 1 {
                        Button(action: {
                            print("タップされました")
                        }) {
                            ZStack {
                                self.boarder(tex: "",
                                            lineWidth: 2.0,
                                            CGPoint(x: 0,   y: 100),
                                            CGPoint(x: 100, y: 100),
                                            Color.orange)
                                self.boarder(tex: "boarder",
                                            lineWidth: 2.0,
                                            CGPoint(x: 0,   y: 0),
                                            CGPoint(x: 100, y: 0),
                                            Color.orange, Color.black)
                            }
                            .frame(width: 100, height: 100, alignment: .center)
                        }
                    }

                    if self.selection == 2 {
                        Text("Hello, World!")
                    }
                }
                ZStack {
                    self.boarder(tex: "", lineWidth: 2.0, CGPoint(x: 0, y: 0), CGPoint(x: geometry.size.width, y: 0), Color.blue)
                        .frame(width: geometry.size.width, height: geometry.size.height/10)
                        .background(Color.yellow)
                        .offset(y: -(self.allSafeArea(geometry, .top) ?? CGFloat()))
                        .background(Color.orange)
                        .offset(y: self.allSafeArea(geometry, .bottom) ?? CGFloat())
                    HStack {
                        self.tabBoarder(modi: TabModifier(selection:  self.$selection,
                                                         viewRouter: self.viewRouter, tag: 1),
                                       lineWidth: 1,
                                       CGPoint(x: geometry.size.width/4, y: self.safeArea(geometry) ? -10 : -20),
                                       CGPoint(x: geometry.size.width/4, y: geometry.size.height/10+(self.allSafeArea(geometry, .bottom) ?? CGFloat())),
                                       Color.blue)
                        self.tabBoarder(modi: TabModifier(selection:  self.$selection,
                                                         viewRouter: self.viewRouter, tag: 2),
                                       lineWidth: 1,
                                       CGPoint(x: geometry.size.width/4, y:  self.safeArea(geometry) ? -10 : -20),
                                       CGPoint(x: geometry.size.width/4, y:  geometry.size.height/(self.safeArea(geometry) ? 12 : 10)+(self.allSafeArea(geometry, .bottom) ?? CGFloat())),
                                       Color.blue)
                        self.tabBoarder(modi: TabModifier(selection:  self.$selection,
                                                         viewRouter: self.viewRouter, tag: 3),
                                       lineWidth: 1,
                                       CGPoint(x: geometry.size.width/4, y:  self.safeArea(geometry) ? -10 : -20),
                                       CGPoint(x: geometry.size.width/4, y:  geometry.size.height/10+(self.allSafeArea(geometry, .bottom) ?? CGFloat())),
                                       Color.blue)
                        self.tabBoarder(modi: TabModifier(selection: self.$selection,
                                                         viewRouter: self.viewRouter, tag: 4),
                                       lineWidth: 1,
                                       CGPoint(x: geometry.size.width/4, y: 0),
                                       CGPoint(x: geometry.size.width/4, y:  geometry.size.height/10+(self.allSafeArea(geometry, .bottom) ?? CGFloat())),
                                       Color.blue)
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
