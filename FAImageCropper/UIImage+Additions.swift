//
//  UIImage+Additions.swift
//  FAImageCropper
//
//  Created by Fahid Attique on 03/06/2017.
//  Copyright © 2017 Fahid Attique. All rights reserved.
//

import Foundation


public extension UIImage {

    public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
}
