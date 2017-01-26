//
//  RestaurantModel.swift
//  Nearby Restaurants
//
//  Created by Juliano Nardon on 25/01/17.
//  Copyright © 2017 Juliano Nardon. All rights reserved.
//

import Foundation

class RestaurantModel
{
    var id : Int?
    var name : String?
    var avaragePrice: Int?
    var briefDescription : String?
    var description : String?
    var defaultPhoto: String?
    var todayVotes: Int?
    var isWinner: Bool?
    var chosenThisWeek: Bool?
    var location : LocationModel?
    
    class func parse(json: [String:AnyObject]) -> RestaurantModel
    {
        let restaurantModel = RestaurantModel()
        
        restaurantModel.id = json["id"] as? Int ?? 0
        restaurantModel.name = json["name"] as? String ?? ""
        restaurantModel.avaragePrice = json["avaragePrice"] as? Int ?? 0
        restaurantModel.briefDescription = json["briefDescription"] as? String ?? ""
        restaurantModel.description = json["description"] as? String ?? ""
        restaurantModel.defaultPhoto = json["defaultPhoto"] as? String ?? ""
        restaurantModel.todayVotes = json["todayVotes"] as? Int ?? 0
        restaurantModel.isWinner = json["isWinner"] as? Bool ?? false
        restaurantModel.chosenThisWeek = json["chosenThisWeek"] as? Bool ?? false
        restaurantModel.location = LocationModel.parse(json["location"] as! [String:AnyObject])
        
        return restaurantModel
    }
    
    class func parseList(json: [[String: AnyObject]]) -> [RestaurantModel]
    {
        var restaurants = [RestaurantModel]()
        
        for restaurntObj in json
        {
            restaurants.append(RestaurantModel.parse(restaurntObj))
        }
        
        return restaurants
    }
}
