//
//  Extension+UIIMage.swift
//  SwiftUI_CustomModifier
//
//  Created by 永田大祐 on 2020/05/22.
//  Copyright © 2020 永田大祐. All rights reserved.
//

import UIKit

extension UIImage {

    func masking(maskImage: UIImage?) -> UIImage? {
        guard let maskImage = maskImage?.cgImage else {
            return nil
        }
        // make Mask
        let mask = CGImage(maskWidth: maskImage.width,
                           height: maskImage.height,
                           bitsPerComponent: maskImage.bitsPerComponent,
                           bitsPerPixel: maskImage.bitsPerPixel,
                           bytesPerRow: maskImage.bytesPerRow,
                           provider: maskImage.dataProvider!,
                           decode: nil, shouldInterpolate: false)!
        //use Mask
        guard let maskedImage = self.cgImage?.masking(mask) else {
            return nil
        }
        return UIImage(cgImage: maskedImage)
    }
    // CGSize resize
    func reSizeImage(reSize: CGSize) -> UIImage? {
        UIGraphicsBeginImageContext(reSize)
        UIGraphicsBeginImageContextWithOptions(reSize,false,UIScreen.main.scale)
        self.draw(in: CGRect(x: 0, y: 0, width: reSize.width, height: reSize.height))
        let reSizeImage:UIImage! = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return reSizeImage ?? UIImage()
    }

    // scale the image at rates
    func scaleImage(scaleSize:CGFloat) -> UIImage? {
        let reSize = CGSize(width: self.size.width * scaleSize, height: self.size.height * scaleSize)
        return reSizeImage(reSize: reSize) ?? UIImage()
    }
}

