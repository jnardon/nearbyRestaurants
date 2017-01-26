//
//  Router.swift
//  Nearby Restaurants
//
//  Created by Juliano Nardon on 26/01/17.
//  Copyright © 2017 Juliano Nardon. All rights reserved.
//

import Foundation

enum Router
{
    case Restaurants([String:AnyObject])
    case Restaurant(Int)
    
    var path: String
    {
        switch self
        {
        case .Restaurants:
            return "_restaurants"
        case .Restaurant(let id):
            return "restaurant_0\(id)"
        }
    }

}