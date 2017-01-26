//
//  BaseManager.swift
//  Nearby Restaurants
//
//  Created by Juliano Nardon on 25/01/17.
//  Copyright © 2017 Juliano Nardon. All rights reserved.
//

import Foundation

class BaseManager
{
    class func firstErrorMessage(json: AnyObject) -> String?
    {
        return ((json["errors"] as? [String: AnyObject])?.values.first as? [String])?.first
    }
    
    class func newRequest(description: String, URL: URLRequestConvertible, callback: (NSURLRequest, NSHTTPURLResponse?, AnyObject, NSError?) -> Void) -> RequestManager
    {
        return RequestManager(description: description, URL: URL, callback: callback)
    }
}
