//
//  ScrollViews.swift
//  SwiftUI_CustomModifier
//
//  Created by 永田大祐 on 2020/05/03.
//  Copyright © 2020 永田大祐. All rights reserved.
//

import SwiftUI

struct TextViews: View {
   @State var desDsign: [Text]
    var body: some View {
        VStack {
            desDsign[0]
                .frame(maxWidth: .infinity,alignment: .center)
            .frame(height: UIScreen.main.bounds.height)
            desDsign[1]
                .frame(maxWidth: .infinity,alignment: .center)
            .frame(height: UIScreen.main.bounds.height)
        }
    }
}
