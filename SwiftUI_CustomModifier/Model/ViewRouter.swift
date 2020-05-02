//
//  ViewRouter.swift
//  SwiftUI_CustomModifier
//
//  Created by 永田大祐 on 2020/04/03.
//  Copyright © 2020 永田大祐. All rights reserved.
//

import SwiftUI

class ViewRouter: ObservableObject {
    @Published var flg = false
    @Published var offsetFlg = false
    @Published var heartView = "heart.fill"
    @Published var appearance = UINavigationBarAppearance()
    @Published var navigationBar = UINavigationBar.appearance()
    @Published var mode =  NavigationBarItem.TitleDisplayMode.automatic
}
