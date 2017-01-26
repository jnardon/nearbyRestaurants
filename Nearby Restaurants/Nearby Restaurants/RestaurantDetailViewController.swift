//
//  RestaurantDetailViewController.swift
//  Nearby Restaurants
//
//  Created by Juliano Nardon on 25/01/17.
//  Copyright © 2017 Juliano Nardon. All rights reserved.
//

import UIKit

class RestaurantDetailViewController: UIViewController
{
    //MARK: Outlets
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var voteButton: UIButton!
    @IBOutlet weak var votesLabel: UILabel!
    @IBOutlet weak var avaragePriceLabel: UILabel!
    
    // MARK: Class Attributes
    var restaurant = RestaurantModel()
    
    // MARK: Instantiate methods
    
    static var storyboardIdentifier: String
    {
        return "restaurant-detail-view-controller"
    }
    
    static var storyboard: UIStoryboard
    {
        return UIStoryboard.mainStoryboard
    }
    
    static func instantiate(restaurant: RestaurantModel) -> RestaurantDetailViewController
    {
        let restaurantDetailViewController = storyboard.instantiateViewControllerWithIdentifier(self.storyboardIdentifier) as! RestaurantDetailViewController
        restaurantDetailViewController.restaurant = restaurant
        
        return restaurantDetailViewController
    }
    
    // MARK: Life Cycle Methods
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.customizeUI()
    }
    
    func customizeUI()
    {
        self.title = self.restaurant.name
        self.descriptionTextView.text = self.restaurant.description
        self.descriptionTextView.scrollsToTop = true
        self.avaragePriceLabel.text = "$ \(self.restaurant.avaragePrice!),00"
        
        if restaurant.chosenThisWeek == true
        {
            self.votesLabel.text = "chosen"
            self.votesLabel.textColor = UIColor(hex: 0xDBD81B)
            self.voteButton.enabled = false
        }
        else
        {
            self.votesLabel.text = "\(self.restaurant.todayVotes!)"
            self.votesLabel.textColor = self.restaurant.isWinner == true ? UIColor(hex: 0x15A99F) : UIColor(hex: 0xE85657)
        }
        
        if UserModel.get().hasVotedToday
        {
            self.voteButton.enabled = false
        }
        
        NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: self.restaurant.defaultPhoto!)!) { data, response, error in
            if (data != nil && error == nil) {
                let image = UIImage(data: data!)
                
                dispatch_async(dispatch_get_main_queue()) {
                    self.logoImageView.image = image
                }
            }
            }.resume()
    }
    
    //MARK: Actions
    @IBAction func voteAction(sender: AnyObject)
    {
        self.voteButton.enabled = false
        let user = UserModel()
        user.hasVotedToday = true
        UserModel.sync(user)
    }
}


