//
//  API.swift
//  Nearby Restaurants
//
//  Created by Juliano Nardon on 25/01/17.
//  Copyright © 2017 Juliano Nardon. All rights reserved.
//

import Foundation

class API
{
    class func requestList(path: String) -> [[String: AnyObject]] {
        
        let url = NSBundle.mainBundle().URLForResource(path, withExtension: "json")
        let data = NSData(contentsOfURL: url!)
        do {
            let object = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
            if let dictionary = object as? [String: AnyObject] {
                return dictionary["restaurants"] as! [[String: AnyObject]]
            }
        } catch {
            // Handle Error
        }
        return  [[String: AnyObject]]()
    }
    
    class func request(path: String) -> [String: AnyObject] {
        
        let url = NSBundle.mainBundle().URLForResource(path, withExtension: "json")
        let data = NSData(contentsOfURL: url!)
        do {
            let object = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
            if let dictionary = object as? [String: AnyObject] {
                return dictionary
            }
        } catch {
            // Handle Error
        }
        return  [String: AnyObject]()
    }
}