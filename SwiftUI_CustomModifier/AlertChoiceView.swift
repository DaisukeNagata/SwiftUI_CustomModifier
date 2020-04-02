//
//  AlertChoiceView.swift
//  SwiftUI_CustomModifier
//
//  Created by 永田大祐 on 2020/04/03.
//  Copyright © 2020 永田大祐. All rights reserved.
//

import SwiftUI

struct AlertChoiceView: View {

    @State private var offSet: CGFloat = UIScreen.main.bounds.height/2
    @State private var selection: Int = 1
    @ObservedObject var viewRouter = ViewRouter()
    @State private var edge: Edge = Edge.bottom
    
    // 画面の閉じる判定
    var body: some View {
        GeometryReader { geometry in
            Text("CustomDialog").frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .onTapGesture {
                    withAnimation {
                        self.viewRouter.flg.toggle()
                    }
            }
            ZStack {
                if self.viewRouter.flg {
                    Color.gray
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .onTapGesture {
                            withAnimation {
                                self.closeAnimation(geometry)
                            }
                    }
                    .opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                    
                    Color.white
                        .transition(.move(edge: self.edge))
                        .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                        .cornerRadius(15, corners: [.topLeft, .topRight])
                        .onTapGesture {
                            self.closeAnimation(geometry)
                    }
                    .gesture(DragGesture()
                    .onChanged({ value in
                        self.offSet = (value.translation.height*0.1) + self.offSet
                    })
                    )
                        .offset(y: self.offSet)
                }
            }
        }
    }
    
    func closeAnimation(_ geo: GeometryProxy) {
        withAnimation(.easeInOut(duration: 0.5)) {
            self.offSet = UIScreen.main.bounds.height
        }
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { timer in
            self.offSet = UIScreen.main.bounds.height/2
            self.viewRouter.flg.toggle()
        }
    }
}
