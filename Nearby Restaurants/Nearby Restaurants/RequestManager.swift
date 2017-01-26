//
//  RequestManager.swift
//  Nearby Restaurants
//
//  Created by Juliano Nardon on 26/01/17.
//  Copyright © 2017 Juliano Nardon. All rights reserved.
//

import Foundation

class RequestManager
{
    class var NoInternetConnection: String
    {
        return "NoInternetConnection"
    }
    
    class var ServerError: String
    {
        return "ServerError"
    }
    
    private var requestObject: Request?
    private let description: String
    private let URL: URLRequestConvertible
    private let callback: (NSURLRequest, NSHTTPURLResponse?, AnyObject, NSError?) -> Void
    
    init(description: String, URL: URLRequestConvertible, callback: (NSURLRequest, NSHTTPURLResponse?, AnyObject, NSError?) -> Void)
    {
        self.description = description
        self.URL = URL
        self.callback = callback
        
        self.retryRequest()
    }
    
    func cancelRequest() -> Void
    {
        self.requestObject?.cancel()
    }
    
    func retryRequest() -> Void
    {
        if RequestManager.hasInternet()
        {
            self.requestObject = self.createRequest()
        }
        else
        {
            self.notifyNoInternetConnection()
        }
    }
    
    private func createRequest() -> Request
    {
        RequestManager.incrementNetworkActivityCount()
        
        return request(self.URL).responseJSON(options: NSJSONReadingOptions.AllowFragments, completionHandler: { response in
            
            RequestManager.decrementNetworkActivityCount()
            
            Async.userInteractive()
                {
                    Async.main()
                        {
                            

                            if let body = response.request?.HTTPBody
                            {
                                do {
                                    let jsonObject = try NSJSONSerialization.JSONObjectWithData(body, options: .AllowFragments)
                                    let jsonData = try NSJSONSerialization.dataWithJSONObject(jsonObject, options: .PrettyPrinted)
                                } catch {
                                }
                            }

                            
                            if response.response?.statusCode == 500 || response.response?.statusCode == 404
                            {
                                self.notifyServerError()
                            }
                            else if response.response?.statusCode == 401 && SessionManager.authenticated()
                            {
                                SessionManager.sharedInstance.logoutUser()
                                Async.main(after: 0.25)
                                {
                                    NSNotificationCenter.defaultCenter().postNotificationName(CurrentSessionDidExpire, object: self)
                                }
                            }
                            else
                            {
                                self.callback(response.request!, response.response, response.result.value ?? NSNull(), response.result.error)
                            }
                            
                    }
            }
            
        })
    }
    
    private func notifyNoInternetConnection() -> Void
    {
        NSNotificationCenter.defaultCenter().postNotificationName(RequestManager.NoInternetConnection, object: self)
    }
    
    private func notifyServerError() -> Void
    {
        NSNotificationCenter.defaultCenter().postNotificationName(RequestManager.ServerError, object: self)
    }
    
    class func decrementNetworkActivityCount()
    {
        AFNetworkActivityIndicatorManager.sharedManager().decrementActivityCount()
    }
    
    class func incrementNetworkActivityCount()
    {
        AFNetworkActivityIndicatorManager.sharedManager().incrementActivityCount()
    }
    
    class func hasInternet() -> Bool
    {
        let reachability: Reachability = Reachability.reachabilityForInternetConnection()
        return reachability.currentReachabilityStatus().rawValue != NotReachable.rawValue
    }
}
