//
//  Nearby_RestaurantsUITests.swift
//  Nearby RestaurantsUITests
//
//  Created by Juliano Nardon on 22/01/17.
//  Copyright © 2017 Juliano Nardon. All rights reserved.
//

import XCTest

class Nearby_RestaurantsUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testVoteFromBegining()
    {
        XCUIDevice.sharedDevice().orientation = .Portrait
        
        let app = XCUIApplication()
        app.alerts["Allow “Nearby Restaurants” to access your location while you use the app?"].buttons["Allow"].tap()
        
        let tablesQuery = app.tables
        tablesQuery.staticTexts["We are an Australian-inspired steakhouse restaurant beloved worldwide."].tap()
        app.scrollViews.containingType(.Button, identifier:"vote").element.tap()
        tablesQuery.staticTexts["Is an American coffee company and coffeehouse chain."].tap()
        app.scrollViews.containingType(.Button, identifier:"vote").element.swipeRight()
        tablesQuery.staticTexts["Is an American fast food restaurant that primarily sells submarine sandwiches and salads."].tap()
        app.buttons["vote"].tap()
        app.scrollViews.containingType(.Button, identifier:"vote").element.swipeRight()
        tablesQuery.staticTexts["McDonald's is an American hamburger and fast food restaurant chain."].tap()
        app.scrollViews.containingType(.Button, identifier:"vote").element.tap()
    
    }
    
}
