//
//  CIMaskModifier.swift
//  SwiftUI_CustomModifier
//
//  Created by 永田大祐 on 2020/05/22.
//  Copyright © 2020 永田大祐. All rights reserved.
//
import SwiftUI
import CoreImage.CIFilterBuiltins

struct CIMaskModifier:  ViewModifier {

    @ObservedObject var ob: CIImageObject
    
    init(ob: CIImageObject) {
        self.ob = ob
        loadImage(ob.checkFlg, named: ob.st, size: CGSize(width: ob.size.width, height: ob.size.height))
    }
    
    func body(content: Content) -> some View {
        ob.image
            .renderingMode(.template)
            .scaledToFit()
            .foregroundColor(Color.red)
            .background(Color.clear)
            .onTapGesture {
                self.ob.checkFlg.toggle()
                self.loadImage(self.ob.checkFlg, named: self.ob.st, size: CGSize(width: self.ob.size.width, height: self.ob.size.height))
        }
    }
    
    private func loadImage(_ obs: Bool, named: String, size: CGSize) {
        
        guard let inputImage = UIImage(named: named) else { return }
        ob.beginImage = CIImage(image: inputImage)!
        
        let context = CIContext()
        let currentFilter = CIFilter.colorMonochrome()
        currentFilter.inputImage = ob.beginImage
        currentFilter.setValue(CIColor(red: 1, green: 1, blue: 1), forKey: "inputColor")
        
        currentFilter.setValue(1, forKey: "inputIntensity")
        currentFilter.intensity = 5
        guard let outputImage = currentFilter.outputImage else { return }
        
        var uiImage = UIImage()
        let imageView = UIImageView()

        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            uiImage = UIImage(cgImage: cgimg)
            ob.beginImage = CIImage(image: uiImage) ?? CIImage()
            imageView.image = uiImage.masking(maskImage: uiImage)?.reSizeImage(reSize: CGSize(width: size.width, height: size.height))
            imageView.image = imageView.image!.scaleImage(scaleSize: 1)
            ob.image = Image(uiImage: imageView.image ?? UIImage())
        }

        if obs {
            // Change Mask
            let contextChange = CIContext()
            let currentFilterChange = CIFilter.colorInvert()
            currentFilterChange.inputImage = ob.beginImage

            guard let outputImageChange = currentFilterChange.outputImage else { return }

            if let cgimgChange = contextChange.createCGImage(outputImageChange, from: outputImage.extent) {
                let uiImageChange = UIImage(cgImage: cgimgChange)
                imageView.image = uiImage.masking(maskImage: uiImageChange)?.reSizeImage(reSize: CGSize(width: size.width, height: size.height))
                imageView.image = imageView.image!.scaleImage(scaleSize: 1)
                ob.image = Image(uiImage: imageView.image ?? UIImage())
            }
        }
    }
}
