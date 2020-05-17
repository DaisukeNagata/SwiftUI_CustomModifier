//
//  PDFParm.swift
//  SwiftUI_CustomModifier
//
//  Created by 永田大祐 on 2020/05/17.
//  Copyright © 2020 永田大祐. All rights reserved.
//

class PDFParm<P,D,B> {

    var path: P
    var document: D
    var bt: B

    init(path: P, document: D, bt: B){
        self.path = path
        self.document = document
        self.bt = bt
    }
}
