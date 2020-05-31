//
//  BoarderLineView.swift
//  SwiftUI_CustomModifier
//
//  Created by 永田大祐 on 2020/06/01.
//  Copyright © 2020 永田大祐. All rights reserved.
//

import SwiftUI

struct BoarderLineView: View {
    var body: some View {
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
}

struct BoarderLineView_Previews: PreviewProvider {
    static var previews: some View {
        BoarderLineView()
    }
}
