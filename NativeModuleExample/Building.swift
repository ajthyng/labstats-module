//
//  Building.swift
//  labview
//
//  Created by Andrew Thyng on 5/2/18.
//  Copyright © 2018 Andrew Thyng. All rights reserved.
//

import Foundation
import GoogleMaps

class Building {
    var name: String = "Building name not found"
    var summary: String = "Lab information not available"
    var usedComputers: Int = 0
    var totalComputers: Int = 0
    var location: CLLocationCoordinate2D?
    init(_ building: NSDictionary) {
        self.name = building["name"] as! String
        self.summary = building["summary"] as! String
        self.usedComputers = building["used"] as! Int
        self.totalComputers = building["total"] as! Int
        let location = building["location"] as! NSDictionary
        let coords = CLLocationCoordinate2D(latitude: location["lat"] as! CLLocationDegrees, longitude: location["long"] as! CLLocationDegrees)
        self.location = coords
    }
    
    func getLabStat() -> String {
        let available = self.totalComputers - self.usedComputers
        let total = self.totalComputers;
        return "\(available)/\(total)"
    }
}
