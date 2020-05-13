//
//  RefreshModel.swift
//  SwiftUI_CustomModifier
//
//  Created by 永田大祐 on 2020/05/03.
//  Copyright © 2020 永田大祐. All rights reserved.
//

import SwiftUI

struct RefreshModel: Identifiable {
    var id: Int
    var timer: Timer?
    var spinner = Spinner(isAnimating: false, style: .large)
}
