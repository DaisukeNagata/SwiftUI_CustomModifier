//
//  PDFModifier.swift
//  SwiftUI_CustomModifier
//
//  Created by 永田大祐 on 2020/05/17.
//  Copyright © 2020 永田大祐. All rights reserved.
//

import SwiftUI

struct PDFModifier: ViewModifier {
    
    // Select the view you like
    @State var pdfView : AnyView
    
    func body(content: Content) -> some View {
        PDFKitRepresentedView(view: AnyView(self.pdfView), name: "SomeThing")
    }
}
