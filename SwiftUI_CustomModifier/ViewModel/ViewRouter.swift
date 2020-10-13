//
//  ViewRouter.swift
//  SwiftUI_CustomModifier
//
//  Created by 永田大祐 on 2020/04/03.
//  Copyright © 2020 永田大祐. All rights reserved.
//

import SwiftUI

class ViewRouter: ObservableObject {

    @Published var alertModel = AlertModel(id:0,
                                           edge: Edge.bottom,
                                           offSet: UIScreen.main.bounds.height/2)
    @Published var designModel = DesignModel(id: 0,
                                             flg: false,
                                             offsetFlg: false,
                                             lineWidth: 0,
                                             heartView: "heart.fill",
                                             titleText: "",
                                             backgroundextColor: UIColor.white,
                                             titleTextTextColor: UIColor.white,
                                             largeTitleTextColor: UIColor.white,
                                             texIndex: ["Hello"])
    @Published var reModel = RefreshModel(id: 0)
    @Published var naviModel = NaviModel(id: 0)

    func isAnimating() -> some View {
        _ = self.reModel.spinner.isAnimating ? self.reModel.spinner.hidden() : nil
        return  self.reModel.spinner
    }
}
