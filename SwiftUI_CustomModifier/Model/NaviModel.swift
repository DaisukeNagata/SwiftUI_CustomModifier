//
//  NaviModel.swift
//  SwiftUI_CustomModifier
//
//  Created by 永田大祐 on 2020/05/03.
//  Copyright © 2020 永田大祐. All rights reserved.
//

import SwiftUI

struct NaviModel: Identifiable {
    let id: Int
    var isHiddenFlg = false
    var mode =  NavigationBarItem.TitleDisplayMode.automatic
}
