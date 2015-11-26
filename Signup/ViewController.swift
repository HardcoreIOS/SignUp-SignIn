//
//  ViewController.swift
//  Signup
//
//  Created by Abdurrahman on 11/24/15.
//  Copyright © 2015 Hafiz Developer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var loginOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loginOutlet.layer.cornerRadius = 15
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

