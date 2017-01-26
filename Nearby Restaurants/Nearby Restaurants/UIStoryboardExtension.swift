//
//  UIStoryboardExtension.swift
//  Nearby Restaurants
//
//  Created by Juliano Nardon on 25/01/17.
//  Copyright © 2017 Juliano Nardon. All rights reserved.
//

import Foundation
import UIKit

extension UIStoryboard
{
    class var mainStoryboard: UIStoryboard
    {
        return UIStoryboard(name: "Main", bundle: nil)
    }
    
    class var launchScreenStoryboard: UIStoryboard
    {
        return UIStoryboard(name: "LaunchScreen", bundle: nil)
    }
}
