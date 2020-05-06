//
//  ViewRouter.swift
//  SwiftUI_CustomModifier
//
//  Created by 永田大祐 on 2020/04/03.
//  Copyright © 2020 永田大祐. All rights reserved.
//

import SwiftUI

class ViewRouter: ObservableObject, TimeLogic {

    @Published var alertModel = AlertModel(id:0,
                                           edge: Edge.bottom,
                                           offSet: UIScreen.main.bounds.height/2)
    @Published var designModel = DesignModel(id: 0,
                                             flg: false,
                                             offsetFlg: false,
                                             offset: 0,
                                             lineWidth: 0,
                                             heartView: "heart.fill",
                                             titleText: "",
                                             backgroundextColor: UIColor.white,
                                             titleTextTextColor: UIColor.white,
                                             largeTitleTextColor: UIColor.white,
                                             texIndex: [Text("Hello")])
    @Published var reModel = RefreshModel(id: 0)
    @Published var naviModel = NaviModel(id: 0)

    var actions = { (_ bindTx: Bool) -> () in return }

    func setupProcessingTimr(_ time: Double, action: @escaping (_ index: Bool) -> Void ) {
        self.reModel.timer = Timer(timeInterval: time, target: self, selector: #selector(timerUpdate), userInfo: nil, repeats: false)
        RunLoop.main.add(self.reModel.timer ?? Timer(), forMode: .default)
        actions = action
    }

    func isAnimating() -> some View {
        if self.reModel.spinner.isAnimating {
            return self.reModel.spinner
        } else {
            _ = self.reModel.spinner.hidden()
        }
        return  self.reModel.spinner
    }

    @objc func timerUpdate()  {
        self.designModel.offset = 0
        self.reModel.id = 0
        actions(false)
        self.reModel.timer?.invalidate()
    }
}
