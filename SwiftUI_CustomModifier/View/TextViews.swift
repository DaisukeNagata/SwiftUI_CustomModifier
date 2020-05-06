//
//  ScrollViews.swift
//  SwiftUI_CustomModifier
//
//  Created by 永田大祐 on 2020/05/03.
//  Copyright © 2020 永田大祐. All rights reserved.
//

import SwiftUI

struct TextViews: View {
    @ObservedObject var viewRouter : ViewRouter
    
    var body: some View {
        VStack {
            ForEach(0..<viewRouter.designModel.texIndex.count, id: \.self) { v in
                self.viewRouter.designModel.texIndex[v]
                    .frame(maxWidth: .infinity,alignment: .center)
                    .frame(height: 100)
                    .background( 0 == (v % 2) ? Color.green : Color.yellow)
            }
        }
    }
}
