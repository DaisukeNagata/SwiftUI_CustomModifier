//
//  TabModifier.swift
//  SwiftUI_CustomModifier
//
//  Created by 永田大祐 on 2020/04/03.
//  Copyright © 2020 永田大祐. All rights reserved.
//

import SwiftUI
class ViewRouter: ObservableObject {
    @Published var heartView = "heart.fill"
    @Published var flg = false
}

//セグメントのイベントデータ
struct Icon: Identifiable {
    let id: Int
    let name: String
}

struct TabModifier: ViewModifier {
    
    // セグメントデータコントロール
    let icon = [
        Icon(id: 0, name: ""),
        Icon(id: 1, name: "clock.fill"),
        Icon(id: 2, name: "heart"),
        Icon(id: 3, name: "arkit"),
        Icon(id: 4, name: "arrow.up.right.video"),
    ]

    let selection: Binding<Int>
    var viewRouter: ViewRouter
    var tag: Int
    var width = UIScreen.main.bounds.width
    
    func body(content: Content) -> some View {
        
        return GeometryReader { geometry in
            VStack {
                if self.tag == 1 {
                    Divider()
                        .frame(width: self.width, alignment: .bottom).offset(y: -8)
                }
            }
            HStack {
                Image(systemName: self.iconName())
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(20)
                    .frame(width: geometry.size.width, height: self.width/4 - 20)
                    .foregroundColor(self.fgColor())
                    .onTapGesture {
                        self.selection.wrappedValue = self.tag
                }
            }
        }
    }

    private func fgColor() -> Color {
        return selection.wrappedValue == self.tag ? Color(UIColor.systemBlue) : Color(UIColor.systemGray)
    }
    
    private func iconName() -> String {
        return selection.wrappedValue == self.tag ? icon[self.tag].name : viewRouter.heartView
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
    
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
