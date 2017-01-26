//
//  UserModel.swift
//  Nearby Restaurants
//
//  Created by Juliano Nardon on 25/01/17.
//  Copyright © 2017 Juliano Nardon. All rights reserved.
//

import Foundation
import RealmSwift

class UserModel: Object
{
    dynamic var id = 1
    dynamic var hasVotedToday : Bool = false
    
    override class func primaryKey() -> String?
    {
        return "id"
    }
    
    
    
    class func sync(userModel: UserModel)
    {
        let realm = try! Realm()
        
        userModel.id = 1
        
        try! realm.write({ () -> Void in
            realm.add(userModel, update: true)
        })
    }
    
    class func get() -> UserModel
    {
        let realm = try! Realm()
        let users = realm.objects(UserModel.self).filter("id = \(1)")
        
        return users.first!
    }
    
    class func set()
    {
        let realm = try! Realm()
        let user = UserModel()
        
        if realm.objects(UserModel.self).filter("id = \(1)").count == 0
        {
            user.id = 1
            user.hasVotedToday = false
        
            try! realm.write({ () -> Void in
                realm.add(user, update: false)
            })
        }
    }

}