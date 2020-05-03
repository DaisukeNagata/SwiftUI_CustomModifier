//
//  TimeLogic.swift
//  SwiftUI_CustomModifier
//
//  Created by 永田大祐 on 2020/05/03.
//  Copyright © 2020 永田大祐. All rights reserved.
//

protocol TimeLogic {
    func setupProcessingTimr(_ time: Double, action: @escaping (_ index: Bool) -> Void )
    func timerUpdate()
}
