//
//  ContentView.swift
//  SwiftUI_CustomModifier
//
//  Created by 永田大祐 on 2020/04/03.
//  Copyright © 2020 永田大祐. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    @State private var selection: Int = 1

    @ObservedObject private var viewRouter = ViewModel()
    private var n : NavigationModifier?
    private var ob: CIImageObject

    init() {

        ob = CIImageObject(size: CGSize(width: 300, height: 300),
                           image: Image("image"),
                           checkFlg: false,
                           beginImage: CIImage())
        
        self.ob.uIImage = UIImage(named: "image")

        viewRouter.designModel = DesignModel(id: 0,
                                             flg: false,
                                             offsetFlg: false,
                                             lineWidth: 0,
                                             heartView: "heart.fill",
                                             titleText: "Welcome",
                                             backgroundextColor: UIColor.green,
                                             titleTextTextColor: UIColor.yellow,
                                             largeTitleTextColor: UIColor.black,
                                             texIndex: ["Hello"])

        self.n = NavigationModifier(view: AnyView(self), viewRouter: self.viewRouter)

        self.viewRouter.naviModel.mode = .inline
    }

    var body: some View {
        GeometryReader { geometry in
            VStack {
                ZStack {

                    self.naviBoarder(modi: self.n ?? NavigationModifier(viewRouter: self.viewRouter),
                                     lineWidth: 2,
                                     CGPoint(x: 0,
                                             y: self.viewRouter.naviModel.mode == .inline ? 44 : 95),
                                     CGPoint(x: geometry.size.width,
                                             y: self.viewRouter.naviModel.mode == .inline ? 44 : 95),
                                     Color.purple)
                        .isHidden(self.viewRouter.naviModel.isHiddenFlg)
                    
                    if self.selection == 2 {
                        BoarderLineView()
                    }

                    if self.selection == 3 {
                        // Select the view you like
                        self.modifier(PDFModifier(pdfView: AnyView(PDFView())))
                    }

                    if self.selection == 4 {
                        // Mask Logic
                        MaskView(ob: self.ob)
                    }
                }

                TabView(geometry: geometry, selection: self.$selection, viewRouter: self.viewRouter)
            }
            self.modifier(AlertModifer(view:  AnyView(AlertChoiceView(viewRouter: self.viewRouter))))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
