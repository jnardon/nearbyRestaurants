//
//  LocationModel.swift
//  Nearby Restaurants
//
//  Created by Juliano Nardon on 25/01/17.
//  Copyright © 2017 Juliano Nardon. All rights reserved.
//

import Foundation
import CoreLocation
import RealmSwift

class LocationModel : Object
{
    var cityName: String?
    var subLocality: String?
    var latitude: CLLocationDegrees?
    var longitude: CLLocationDegrees?
    
    class func parse(json: [String:AnyObject]) -> LocationModel
    {
        let location = LocationModel()
        
        location.cityName = json["cityName"] as? String ?? ""
        location.subLocality = json["subLocality"] as? String ?? ""
        location.latitude = json["latitude"] as? CLLocationDegrees ?? 0.0
        location.longitude = json["longitude"] as? CLLocationDegrees ?? 0.0
        
        return location
    }
}
