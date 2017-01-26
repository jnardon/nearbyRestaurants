//
//  RestaurantsViewController.swift
//  Nearby Restaurants
//
//  Created by Juliano Nardon on 25/01/17.
//  Copyright © 2017 Juliano Nardon. All rights reserved.
//

import UIKit

class RestaurantsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    //MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // Mark: Class Attributes
    var userLocation: LocationModel?
    var restaurants = [RestaurantModel]()
    
    // MARK: Instantiate methods
    
    static var storyboardIdentifier: String
    {
        return "restaurants-view-controller"
    }
    
    static var storyboard: UIStoryboard
    {
        return UIStoryboard.mainStoryboard
    }
    
    static func instantiate(userLocation: LocationModel, restaurants: [RestaurantModel]) -> RestaurantsViewController
    {
        let restaurantsViewController = storyboard.instantiateViewControllerWithIdentifier(self.storyboardIdentifier) as! RestaurantsViewController
        restaurantsViewController.userLocation = userLocation
        restaurantsViewController.restaurants = restaurants
        
        return restaurantsViewController
    }

    // MARK: Life Cycle Methods
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "Nearby Restaurants"
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        self.tableView.headerViewForSection(0)?.textLabel?.text = self.userLocation!.cityName
    }
    
    // MARK: UITableViewDataSource Methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.restaurants.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier(RestaurantTableViewCell.identifer, forIndexPath: indexPath) as! RestaurantTableViewCell
        cell.setUpCell(self.restaurants[indexPath.row])
        
        return cell
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let headerCell = tableView.dequeueReusableCellWithIdentifier(RestaurantTableViewHeader.identifer) as! RestaurantTableViewHeader
        headerCell.setUpWith(self.userLocation!)
        
        return headerCell
    }
    
    // MARK: UITableViewDelegate Methods
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        
        let id = self.restaurants[indexPath.row].id!
        let restaurant = RestaurantModel.parse(API.request(Router.Restaurant(id).path))
        let restaurantDetailViewController = RestaurantDetailViewController.instantiate(restaurant)
        self.navigationController?.pushViewController(restaurantDetailViewController, animated: true)
        
    }

}

