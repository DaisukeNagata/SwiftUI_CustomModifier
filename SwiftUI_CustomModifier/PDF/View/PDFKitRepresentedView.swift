//
//  PDFKitRepresentedView.swift
//  SwiftUI_CustomModifier
//
//  Created by 永田大祐 on 2020/05/17.
//  Copyright © 2020 永田大祐. All rights reserved.
//

import SwiftUI

struct PDFKitRepresentedView: UIViewControllerRepresentable {

    @State var view: AnyView
    @State var name: String
    
    @State private var viewController = UIViewController()
    @ObservedObject private var sti = PramViewModel()

    func makeUIViewController(context: UIViewControllerRepresentableContext<PDFKitRepresentedView>) -> UIViewController {
        DispatchQueue.main.async {
            self.sti.set.document.delegate = context.coordinator
            let view = UIHostingController(rootView: self.view).view
            // Please specify the vertical and horizontal
            view?.frame.size.height = UIScreen.main.bounds.height
            view?.frame.size.width = UIScreen.main.bounds.width
            self.viewController.view.addSubview(view ?? UIView())
            CreatePDF.btn(view: self.viewController.view, st: self.name, stI: self.sti)
        }
        return viewController
    }

    func makeCoordinator() -> Coordintor { return Coordintor(owner: self) }

    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<PDFKitRepresentedView>) {}

    final class Coordintor: NSObject, UIDocumentInteractionControllerDelegate {
        let owner: PDFKitRepresentedView
        init(owner: PDFKitRepresentedView) {
            self.owner = owner
        }
        func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
            return owner.viewController
        }

        func documentInteractionControllerDidEndPreview(_ controller: UIDocumentInteractionController) {
            controller.delegate = nil
        }
    }
}
