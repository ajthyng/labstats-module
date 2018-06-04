//
//  DrawerViewController.swift
//  NativeModuleExample
//
//  Created by Andrew Thyng on 5/14/18.
//  Copyright © 2018 DubLabs LLC. All rights reserved.
//

import Pulley
import UIKit
import Foundation


class DrawerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var buildingTable: UITableView!
    @IBOutlet var visibleDrawerView: UIView!
    var buildings = Array<Building>()
    let concurrentQueue = DispatchQueue(label: "buildings", attributes: .concurrent)
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return buildings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let buildingCell = tableView.dequeueReusableCell(withIdentifier: "BuildingCell") as! BuildingCell
        let bldg = buildings[indexPath.row]
        buildingCell.blgdName.text = bldg.name
        buildingCell.labCount.text = bldg.getLabStat()
        
        return buildingCell
    }
    
    func getLabStats(completion: @escaping (_ labstats: NSArray) -> Void) {
        concurrentQueue.async {
            if let url = URL(string: "http://ajt79.its.txstate.edu:3030") {
                var req = URLRequest(url: url)
                req.httpMethod = "GET"
                let sessionConfig = URLSessionConfiguration.default
                sessionConfig.timeoutIntervalForResource = 10
                let session = URLSession(configuration: sessionConfig)
                session.dataTask(with: req) { (data, response, error) in
                    if let error = error {
                        print (error.localizedDescription)
                        return
                    }
                    if let data = data {
                        do {
                            let computerBuildings = try JSONSerialization.jsonObject(with: NSData.init(data: data) as Data) as! NSArray
                            completion(computerBuildings)
                        } catch let error as NSError {
                            print (error.localizedDescription)
                        }
                    }
                    }.resume()
            }
        }
    }
    
    override func viewDidLoad() {
        getLabStats() { (computerBuildings) in
            DispatchQueue.main.async {
                for building in computerBuildings {
                    let localBldg = Building(building as! NSDictionary)
                    self.buildings.append(localBldg)
                }
                self.buildingTable.reloadData()
            }
        }
    }
}

extension DrawerViewController: PulleyDrawerViewControllerDelegate {
    func collapsedDrawerHeight(bottomSafeArea: CGFloat) -> CGFloat {
        return visibleDrawerView.frame.height
    }
    
    func partialRevealDrawerHeight(bottomSafeArea: CGFloat) -> CGFloat {
        return UIScreen.main.bounds.height / 2
    }
    
    func supportedDrawerPositions() -> [PulleyPosition] {
        return [PulleyPosition.collapsed, PulleyPosition.partiallyRevealed]
    }
}
