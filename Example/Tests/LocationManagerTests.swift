//
//  LocationManagerTests.swift
//  LocationSimulator_Tests
//
//  Created by Qing Cai on 05/04/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
import LocationSimulator
import CoreLocation

/**
 LocationManager's testable delegate
 */
class LocationManagerDelegate: NSObject, CLLocationManagerDelegate {
    
    var expectation: XCTestExpectation?
    
    func setExpectation(expectation: XCTestExpectation) {
        self.expectation = expectation
    }
    
    var count = 0
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        count += 1
        if (count == 4) {
            expectation!.fulfill()
        }
    }
}

/**
 Test LocationManager features
 */
class LocationManagerTests: XCTestCase {

    var locationManager = LSLocationManager(builtInLocationFileName: "cycle.gpx")
    var locationManagerDelegate: LocationManagerDelegate?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        locationManagerDelegate = LocationManagerDelegate()
        locationManager.delegate = locationManagerDelegate
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_didUpdateLocations_called_five_times() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        locationManagerDelegate!.setExpectation(expectation: expectation(description: "Cancel"))
        locationManager.startUpdatingLocation()
        waitForExpectations(timeout: 5, handler: nil)
    }
}
