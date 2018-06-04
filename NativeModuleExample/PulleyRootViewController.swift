//
//  PulleyRootViewController.swift
//  NativeModuleExample
//
//  Created by Andrew Thyng on 5/14/18.
//  Copyright © 2018 DubLabs LLC. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import GoogleMaps
import Pulley

class PulleyRootViewController: PulleyViewController, CLLocationManagerDelegate {
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var mapController: MapViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
}
