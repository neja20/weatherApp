//
//  LocationManager.swift
//  MyWearherApp
//
//  Created by D N on 25/07/2019.
//  Copyright © 2019 Daniel Nejezchleb. All rights reserved.
//

import Foundation
import CoreLocation

class LocationManager : NSObject, CLLocationManagerDelegate
{
    // Properties
    lazy var locationManager = CLLocationManager()
    var cb : ((CLLocation)->())?
    
    override init()
    {
        super.init()

        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        self.locationManager.requestWhenInUseAuthorization()
    }
    
    func getLocation(completion: @escaping (CLLocation)->())
    {
        self.locationManager.requestLocation()
        self.cb = completion
    }
    
    // delegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        if let loc = locations.first
        {
            if(self.cb != nil) {self.cb!(loc)}
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        //
    }
}
