//
//  RestaurantTableViewCell.swift
//  Nearby Restaurants
//
//  Created by Juliano Nardon on 25/01/17.
//  Copyright © 2017 Juliano Nardon. All rights reserved.
//

import UIKit

class RestaurantTableViewCell: UITableViewCell
{
    
    static var identifer: String
    {
        return "restaurant-cell"
    }
    
    // MARK: Outlets
    @IBOutlet weak var restaurantLogoImageView: UIImageView!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var restaurantDescriptionLabel: UILabel!
    @IBOutlet weak var votesLabel: UILabel!
    
    
    //MARK: UITableViewCell methods
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        self.customizeUI()
    }
    
    override func prepareForReuse()
    {
        super.prepareForReuse()
        
        self.restaurantLogoImageView.image = UIImage()
        self.restaurantNameLabel.text = ""
        self.restaurantDescriptionLabel.text = ""
        self.votesLabel.text = ""
    }
    
    //MARK: Methods
    func setUpCell(restaurant: RestaurantModel)
    {
        self.restaurantNameLabel.text = restaurant.name
        self.restaurantDescriptionLabel.text = restaurant.briefDescription
        
        if restaurant.chosenThisWeek == true
        {
            self.votesLabel.text = "chosen"
            self.votesLabel.textColor = UIColor(hex: 0xDBD81B)
        }
        else
        {
            self.votesLabel.text = "\(restaurant.todayVotes!) votes today"
            self.votesLabel.textColor = restaurant.isWinner == true ? UIColor(hex: 0x15A99F) : UIColor(hex: 0xE85657)
        }
        
        NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: restaurant.defaultPhoto!)!) { data, response, error in
            if (data != nil && error == nil) {
                let image = UIImage(data: data!)
                
                dispatch_async(dispatch_get_main_queue()) {
                    self.restaurantLogoImageView.image = image
                }
            }
            }.resume()
        
    }
    
    func customizeUI()
    {
        self.restaurantLogoImageView?.layer.cornerRadius = 2
        self.restaurantLogoImageView.clipsToBounds = true
    }
}
