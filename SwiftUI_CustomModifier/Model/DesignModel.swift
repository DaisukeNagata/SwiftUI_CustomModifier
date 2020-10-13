//
//  DesignModel.swift
//  SwiftUI_CustomModifier
//
//  Created by 永田大祐 on 2020/05/03.
//  Copyright © 2020 永田大祐. All rights reserved.
//

import SwiftUI

struct DesignModel: Identifiable {
    
    let id: Int
    var flg: Bool
    var offsetFlg: Bool
    var lineWidth: CGFloat
    var heartView = "heart.fit"
    var titleText  : String
    var backgroundextColor: UIColor
    var titleTextTextColor: UIColor
    var largeTitleTextColor: UIColor
    var texIndex: [String]
}
