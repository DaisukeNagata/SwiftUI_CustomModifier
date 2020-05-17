//
//  PramViewModel.swift
//  SwiftUI_CustomModifier
//
//  Created by 永田大祐 on 2020/05/17.
//  Copyright © 2020 永田大祐. All rights reserved.
//

import SwiftUI

final class PramViewModel: ObservableObject {
    @Published var set = PDFParm(path: String(), document: UIDocumentInteractionController(), bt: UIButton())
}
