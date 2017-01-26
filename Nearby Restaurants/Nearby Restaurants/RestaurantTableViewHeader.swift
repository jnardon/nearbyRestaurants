//
//  RestaurantTableViewHeader.swift
//  Nearby Restaurants
//
//  Created by Juliano Nardon on 25/01/17.
//  Copyright © 2017 Juliano Nardon. All rights reserved.
//

import UIKit

class RestaurantTableViewHeader: UITableViewCell
{
    
    @IBOutlet weak var cityLabel: UILabel!
    
    static var identifer: String
    {
        return "header-restaurant-cell"
    }
    
    //MARK: UITableViewCell methods
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }
    
    override func prepareForReuse()
    {
        super.prepareForReuse()
    }
    
    func setUpWith(location: LocationModel)
    {
        self.cityLabel.text = "Nearby \(location.subLocality!), \(location.cityName!)"
    }
}
