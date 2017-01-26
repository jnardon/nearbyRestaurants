//
//  LoaderViewController.swift
//  Nearby Restaurants
//
//  Created by Juliano Nardon on 25/01/17.
//  Copyright © 2017 Juliano Nardon. All rights reserved.
//

import CoreLocation
import UIKit
import EventKit

class LoaderViewController: UIViewController, CLLocationManagerDelegate
{
    // MARK: Outlets
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK: Attributes
    let locationManager = CLLocationManager()
    var userLocation = LocationModel()
    var reminder = EKReminder()
    var eventStore: EKEventStore!
    var reminders: [EKReminder]!
    
    // MARK: Life Cycle Methods
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.activityIndicator.startAnimating()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.findMyLocation()
    }
    
    //MARK: LocationManager Methods
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        CLGeocoder().reverseGeocodeLocation(manager.location!, completionHandler: {(placemarks, error)->Void in
            
            if (error != nil)
            {
                print("Reverse geocoder failed with error" + error!.localizedDescription)
                return
            }
            
            if placemarks!.count > 0
            {
                let pm = placemarks![0]
                self.setLocationFromUser(pm)
            }
            else
            {
                print("Problem with the data received from geocoder")
            }
        })
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError)
    {
        print("Error while updating location " + error.localizedDescription)
    }
    
    // MARK: Methods
    func findMyLocation()
    {
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.requestLocation()

    }
    
    func setLocationFromUser(placemark: CLPlacemark?)
    {
        if let containsPlacemark = placemark
        {
            self.locationManager.stopUpdatingLocation()
            
            self.userLocation.cityName = containsPlacemark.locality != nil ? containsPlacemark.locality : ""
    
            self.userLocation.subLocality = containsPlacemark.subLocality != nil ? containsPlacemark.subLocality : ""
            self.userLocation.latitude = containsPlacemark.location?.coordinate.latitude
            self.userLocation.longitude = containsPlacemark.location?.coordinate.longitude

            self.populateRestaurants()
        }
    }
    
    func populateRestaurants()
    {
        var params = [String:AnyObject]()
        params["latitude"] = self.userLocation.latitude
        params["longitude"] = self.userLocation.longitude
        
        let restaurants = RestaurantModel.parseList(API.requestList(Router.Restaurants(params).path))
        
        UserModel.set()
        
        let restaurantsViewController = RestaurantsViewController.instantiate(self.userLocation, restaurants: restaurants)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.pushViewController(restaurantsViewController, animated: true)
    }
    
    func requestPermissionToNotification()
    {
        let notificationSettings = UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(notificationSettings)
        
        let gregorian = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        let now = NSDate()
        let components = gregorian.components([.Year, .Month, .Day, .Hour, .Minute, .Second], fromDate: now)
        
        components.hour = 12
        components.minute = 45
        components.second = 0
        
        
        let date = gregorian.dateFromComponents(components)!
        
        let notification = UILocalNotification()
        notification.fireDate = date
        notification.repeatInterval = NSCalendarUnit.Day
        notification.alertBody = "Restaurant Chosen!"
        notification.alertAction = "open"
        notification.hasAction = true
        notification.userInfo = ["UUID": "reminderID" ]
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
  
}
