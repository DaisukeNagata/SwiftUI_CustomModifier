//
//  AlertChoiceView.swift
//  SwiftUI_CustomModifier
//
//  Created by 永田大祐 on 2020/04/03.
//  Copyright © 2020 永田大祐. All rights reserved.
//

import SwiftUI

struct AlertChoiceView: View {

    @State private var selection: Int = 1
    @ObservedObject var viewRouter: ViewModel

    // 画面の閉じる判定
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                if self.viewRouter.designModel.flg {
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
                        .transition(.move(edge: self.viewRouter.alertModel.edge))
                        .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                        .cornerRadius(15, corners: [.topLeft, .topRight])
                        .onTapGesture {
                            self.closeAnimation(geometry)
                    }
                    .gesture(DragGesture()
                    .onChanged({ value in
                        self.viewRouter.alertModel.offSet = (value.translation.height*0.1) + self.viewRouter.alertModel.offSet
                    })
                    )
                        .offset(y: self.viewRouter.alertModel.offSet)
                }
            }
        }
    }

    func closeAnimation(_ geo: GeometryProxy) {
        withAnimation(.easeInOut(duration: 0.5)) {
            self.viewRouter.alertModel.offSet = UIScreen.main.bounds.height
        }
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { timer in
            self.viewRouter.alertModel.offSet = UIScreen.main.bounds.height/2
            self.viewRouter.designModel.flg.toggle()
        }
    }
}
