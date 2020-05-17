//
//  CreatePDF.swift
//  SwiftUI_CustomModifier
//
//  Created by 永田大祐 on 2020/05/17.
//  Copyright © 2020 永田大祐. All rights reserved.
//

import UIKit

final class CreatePDF {

    class func btn(view: UIView,st :String, stI: PramViewModel) {

        stI.set.bt.setTitle("\(st).pdf", for: .highlighted)

        guard let dir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
            .last else
        { return }

        guard let path2 = NSURL(fileURLWithPath:dir)
            .appendingPathComponent("\(st).pdf")?
            .path else
        { return }

        stI.set.path = path2
        make(views: view, path: path2, stI: stI)
    }

    private class func make(views: UIView, path: String, stI: PramViewModel) {

        UIGraphicsBeginPDFContextToFile(path, CGRect.zero, nil)

        renderViews(views: [views], stI: stI)
        UIGraphicsEndPDFContext()
        
    }

    private class func renderViews(views: [UIView], stI: PramViewModel) {
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        views.forEach {
            UIGraphicsBeginPDFPageWithInfo(UIScreen.main.bounds, nil)
            $0.layer.render(in: context)
        }
        
        stI.set.document = UIDocumentInteractionController(url: URL(fileURLWithPath: stI.set.path))
        if stI.set.document.presentOpenInMenu(from: UIScreen.main.bounds, in: views[0], animated: true) {
            print("Nothing")
        }
    }
}
