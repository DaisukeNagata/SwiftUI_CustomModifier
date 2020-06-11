//
//  Extension+View.swift
//  SwiftUI_CustomModifier
//
//  Created by 永田大祐 on 2020/04/03.
//  Copyright © 2020 永田大祐. All rights reserved.
//

import SwiftUI

enum Area {
    case top, bottom, leading
}

extension View {

    func isHidden(_ bool: Bool) -> some View {
        modifier(HiddenModifier(isHidden: bool))
    }
    
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
    
    func naviBoarder(modi: NavigationModifier,
                lineWidth: CGFloat,
                _ rectMove: CGPoint,
                _ rectLine: CGPoint,
                _ color: Color,
                _ texColor: Color? = nil) -> some View {
        ZStack {
            self.modifier(modi)
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

    func tabBoarder(modi: TabModifier,
                lineWidth: CGFloat,
                _ rectMove: CGPoint,
                _ rectLine: CGPoint,
                _ color: Color,
                _ texColor: Color? = nil) -> some View {
        ZStack {
            self.modifier(modi)
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

    func boarder(tex:String,
                lineWidth: CGFloat,
                _ rectMove: CGPoint,
                _ rectLine: CGPoint,
                _ color: Color,
                _ texColor: Color? = nil) -> some View {
        ZStack {
            Text(tex).frame(width: rectLine.x, height: rectLine.y).foregroundColor(texColor)
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

    func allSafeArea(_ safeArea: GeometryProxy, _ area: Area) -> CGFloat? {
        switch area {
        case Area.top: return safeArea.safeAreaInsets.top
        case Area.bottom: return safeArea.safeAreaInsets.bottom
        case Area.leading: return safeArea.safeAreaInsets.leading
        }
    }
    
    func safeArea(_ safeArea: GeometryProxy) -> Bool {
        return safeArea.safeAreaInsets.bottom == 0 ? false : true
    }
}


private struct HiddenModifier: ViewModifier {

    fileprivate let isHidden: Bool

    fileprivate func body(content: Content) -> some View {
        Group {
            if isHidden {
                content.hidden()
            } else {
                content
            }
        }
    }
}
