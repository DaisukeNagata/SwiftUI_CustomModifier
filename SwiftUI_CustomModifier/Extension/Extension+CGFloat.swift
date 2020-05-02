//
//  Extension+CGFloat.swift
//  SwiftUI_CustomModifier
//
//  Created by 永田大祐 on 2020/05/03.
//  Copyright © 2020 永田大祐. All rights reserved.
//
import UIKit

extension CGFloat {
    // SE Check
    func seCheck() -> Bool {
        if UIDevice.current.userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                return true
            default: break
            }
        }
        return false
    }
}
