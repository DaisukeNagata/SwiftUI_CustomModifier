//
//  TabView.swift
//  SwiftUI_CustomModifier
//
//  Created by 永田大祐 on 2020/06/01.
//  Copyright © 2020 永田大祐. All rights reserved.
//

import SwiftUI

struct TabView: View {
    
    var geometry: GeometryProxy
    @Binding var selection: Int
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
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
                                                      viewModel: self.viewModel, tag: i+1),
                                    lineWidth: 1,
                                    CGPoint(x: self.geometry.size.width/4,
                                            y: self.safeArea(self.geometry) ? -10 : -20),
                                    CGPoint(x: self.geometry.size.width/4,
                                            y: self.geometry.size.height/(self.safeArea(self.geometry) ? i+1 == 2 ? 12 : 10 : 10)+(self.allSafeArea(self.geometry, .bottom) ?? CGFloat())),
                                    Color.blue)
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height/10)
        }
    }
}
