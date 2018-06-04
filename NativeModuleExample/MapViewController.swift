//
//  MapViewController.swift
//  
//
//  Created by Andrew Thyng on 5/14/18.
//

import UIKit
import GoogleMaps
import GooglePlaces

class MapViewController : UIViewController {
    var locationManager = CLLocationManager()
    var CurrentLocation: CLLocation?
    var googleMapView: GMSMapView?
    
    override func loadView() {
        let lat: CLLocationDegrees = 29.889040
        let long: CLLocationDegrees = -97-943024
        let startLocation = CLLocationCoordinate2DMake(lat, long)
        let camera = GMSCameraPosition.camera(withTarget: startLocation, zoom: 16)
        googleMapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        locationManager.delegate = self
        
        if let mapView = googleMapView {
            mapView.delegate = self
            mapView.isMyLocationEnabled = true
            view = mapView
        }
    }
}

extension MapViewController: CLLocationManagerDelegate {
    
}

extension MapViewController: GMSMapViewDelegate {
    
}
