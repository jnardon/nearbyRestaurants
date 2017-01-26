//
//  UIColorExtension.swift
//  Nearby Restaurants
//
//  Created by Juliano Nardon on 26/01/17.
//  Copyright © 2017 Juliano Nardon. All rights reserved.
//

import UIKit

extension UIColor
{
    
    convenience init(hex: Int32, alpha: CGFloat)
    {
        let r = CGFloat((hex >> 16) & 0xFF)
        let g = CGFloat((hex >> 8) & 0xFF)
        let b = CGFloat((hex) & 0xFF)
        
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: alpha)
    }
    
    convenience init(hex: Int32)
    {
        self.init(hex: hex, alpha: 1.0)
    }
}
