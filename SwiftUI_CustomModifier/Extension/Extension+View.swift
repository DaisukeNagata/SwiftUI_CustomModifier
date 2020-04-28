//
//  Extension+View.swift
//  SwiftUI_CustomModifier
//
//  Created by 永田大祐 on 2020/04/03.
//  Copyright © 2020 永田大祐. All rights reserved.
//

import SwiftUI

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
    func border(lineWidth: CGFloat,
                _ rectMove: CGPoint,
                _ rectLine: CGPoint,
                _ color: Color) -> some View {
        ZStack {
            Path { path in
                path.move(to: rectMove)
                path.addLine(to: rectLine)
            }
            .stroke(color,
                    style: StrokeStyle(
                        lineWidth: lineWidth,
                        lineCap: .round,
                        lineJoin: .round,
                        miterLimit: 0,
                        dash: [],
                        dashPhase: 0
                )
            )
        }
    }
}
