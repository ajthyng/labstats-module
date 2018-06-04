//
//  FirstPageViewController.swift
//  NativeModuleExample
//
//  Created by Stanislav on 7/23/17.
//  Copyright © 2017 DubLabs LLC. All rights reserved.
//

import Foundation
import DubLabsSDK

public class ModuleOneViewController:DUBViewController {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        let textView = UITextView.init(frame: self.view.bounds)
        textView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
           
        if let config = DUBApp.defaultApp().getModule("NewsModule") {
             textView.text = String.init(format: "%@", config)
        } else {
             textView.text = "Not found (null)"
        }
        self.view.addSubview(textView)
        
    }
    
}
