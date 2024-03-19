//
//  ColorToImage.swift
//  iOS_Nuflect
//
//  Created by Jiwoong's MacBook Air on 3/19/24.
//

import UIKit

// UIColor -> UIImage
let cornerRadius = 11.0

func image(withColor color: UIColor) -> UIImage {
    let size = CGSize(width: 1, height: 1)
    UIGraphicsBeginImageContextWithOptions(size, false, 0)
    color.setFill()
    
    let path = UIBezierPath(roundedRect: CGRect(origin: .zero, size: size), cornerRadius: cornerRadius)
    path.fill()
    
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return image!
}

