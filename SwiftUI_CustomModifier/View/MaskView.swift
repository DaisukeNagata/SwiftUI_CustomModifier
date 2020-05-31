//
//  MaskView.swift
//  SwiftUI_CustomModifier
//
//  Created by 永田大祐 on 2020/06/01.
//  Copyright © 2020 永田大祐. All rights reserved.
//

import SwiftUI

struct MaskView: View {
    
    var ob: CIImageObject
    @State private var offset: CGFloat = 0
    @State private var offsetY: CGFloat = 0

    var body: some View {
        // Mask Logic
        ZStack {
            Text("印")
                .frame(maxWidth: .infinity, maxHeight: 100)
                .font(.title)
            self.modifier(CIMaskModifier(ob: self.ob)).offset(x: self.offset, y: self.offsetY)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .gesture(DragGesture()
        .onChanged{ value in
            self.offset = value.translation.width
            self.offsetY = value.translation.height
            }
        )
    }
}
