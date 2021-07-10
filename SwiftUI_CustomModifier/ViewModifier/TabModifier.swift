//
//  TabModifier.swift
//  SwiftUI_CustomModifier
//
//  Created by 永田大祐 on 2020/04/03.
//  Copyright © 2020 永田大祐. All rights reserved.
//

import SwiftUI

struct TabModifier: ViewModifier {
    
    // セグメントデータコントロール
    let icon = [
        Icon(id: 0, name: ""),
        Icon(id: 1, name: "clock.fill"),
        Icon(id: 2, name: "heart"),
        Icon(id: 3, name: "square.and.arrow.up.fill"),
        Icon(id: 4, name: "arrow.up.right.video"),
    ]

    let selection: Binding<Int>
    var viewModel: ViewModel
    var tag: Int
    
    func body(content: Content) -> some View {
        GeometryReader { geometry in
            HStack {
                Image(systemName: self.iconName())
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(geometry.size.width/5)
                    .frame(width: geometry.size.width, height: geometry.size.width - 20)
                    .offset(y: self.offsetY(geo: geometry))
                    .foregroundColor(self.fgColor())
                    .onTapGesture {
                        self.selection.wrappedValue = self.tag
                        self.viewModel.designModel.offsetFlg.toggle()
                        // this is Navigation on/off
                        self.selection.wrappedValue == 1 ? self.viewModel.naviModel.isHiddenFlg.toggle() : nil
                }
            }
        }
    }

    private func fgColor() -> Color { return selection.wrappedValue == self.tag ? Color(UIColor.systemBlue) : Color(UIColor.systemGray) }

    private func iconName() -> String { return selection.wrappedValue == self.tag ? icon[self.tag].name : viewModel.designModel.heartView }

    private func offsetY(geo: GeometryProxy) -> CGFloat { if viewModel.designModel.offsetFlg { return selection.wrappedValue == self.tag ? -geo.size.height : 0 }
        return 0
    }
}
