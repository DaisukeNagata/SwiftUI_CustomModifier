//
//  AlertModifer.swift
//  SwiftUI_CustomModifier
//
//  Created by 永田大祐 on 2020/04/03.
//  Copyright © 2020 永田大祐. All rights reserved.
//

import SwiftUI

struct AlertModifer: ViewModifier {
    var view: AnyView? = AnyView( EmptyView() ) {
        didSet {
            print("AlertModifer")
            
        }
    }

    func body(content: Content) -> some View {
        return view
    }
}
