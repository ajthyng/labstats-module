//
//  RootViewController.swift
//  NativeModuleExample
//
//  Created by Stanislav on 7/23/17.
//  Copyright © 2017 DubLabs LLC. All rights reserved.
//

import Foundation
import DubLabsSDK

public class RootViewController: NSObject {
    
    public class func moduleOneViewController() -> UIViewController {
        return ModuleOneViewController()
    }
    
    public class func moduleTwoViewController() -> UIViewController {
        return ModuleTwoViewController()
    }
    
}
