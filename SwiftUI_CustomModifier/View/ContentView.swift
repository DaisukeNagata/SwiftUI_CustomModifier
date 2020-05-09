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
    var n: NavigationModifier?

    init() {
        viewRouter.designModel = DesignModel(id: 0,
                                             flg: false,
                                             offsetFlg: false,
                                             offset: 0,
                                             lineWidth: 0,
                                             heartView: "heart.fill",
                                             titleText: "Welcome",
                                             backgroundextColor: UIColor.green,
                                             titleTextTextColor: UIColor.yellow,
                                             largeTitleTextColor: UIColor.black,
                                             texIndex: [Text("Hello")])
        self.n = NavigationModifier(view: AnyView(self), viewRouter: self.viewRouter)
        self.viewRouter.naviModel.mode = .inline
    }

    var body: some View {
        GeometryReader { geometry in
            VStack {
                ZStack {

                    self.naviBoarder(modi: self.n ?? NavigationModifier(view: AnyView(self), viewRouter: self.viewRouter),
                                           lineWidth: 2,
                                           CGPoint(x: 0,
                                                   y: self.viewRouter.naviModel.mode == .inline ? 44 : 95),
                                           CGPoint(x: geometry.size.width,
                                                   y: self.viewRouter.naviModel.mode == .inline ? 44 : 95),
                                           Color.purple)

                    if self.selection == 2 {
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

                    if self.selection == 3 {
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
                        ForEach(0..<4) { i in
                            self.tabBoarder(modi: TabModifier(selection:  self.$selection,
                                                              viewRouter: self.viewRouter, tag: i+1),
                                                              lineWidth: 1,
                                                              CGPoint(x: geometry.size.width/4,
                                                                      y: self.safeArea(geometry) ? -10 : -20),
                                                              CGPoint(x: geometry.size.width/4,
                                                                      y: geometry.size.height/(self.safeArea(geometry) ? i+1 == 2 ? 12 : 10 : 10)+(self.allSafeArea(geometry, .bottom) ?? CGFloat())),
                                                                       Color.blue)
                        }
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
