//
//  ViewController.swift
//  Signup
//
//  Created by Abdurrahman on 11/24/15.
//  Copyright © 2015 Hafiz Developer. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {

    @IBOutlet weak var loginOutlet: UIButton!
    
    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loginOutlet.layer.cornerRadius = 15
        
    }

    @IBAction func logInButtonPressed(sender: AnyObject) {
        
        let userEmail = emailAddressTextField.text
        let userPassword = passwordTextField.text
        
        if emailAddressTextField.text == "" || emailAddressTextField.text == nil || passwordTextField.text == "" || passwordTextField.text == nil {
            
            let alertController = UIAlertController(title: "Error", message: "Please make sure that you fill in your email and password", preferredStyle: .Alert)
            alertController.addAction(UIAlertAction(title: "Got it", style: .Default, handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
            
        }
        
        var userMessage = "Welcome back, let's get going!"
        
        PFUser.logInWithUsernameInBackground(userEmail!, password: userPassword!) { (user: PFUser?, error: NSError?) -> Void in
            
            if user != nil {
                
                // Remember signIn state
                let userName: String? = user?.username
                
                NSUserDefaults.standardUserDefaults().setObject(userName, forKey: "user_name")
                
                NSUserDefaults.standardUserDefaults().synchronize()
                
                // Navigate to protected page
                
//                let mainStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//                
//                var mainPage: MainPageViewController = mainStoryBoard.instantiateViewControllerWithIdentifier("MainPageViewController") as! MainPageViewController
//                
//                var mainPageNav = UINavigationController(rootViewController: mainPage)
//                
//                var appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//                
//                appDelegate.window?.rootViewController = mainPageNav
               
                let alertController = UIAlertController(title: "Welcome back", message: "Let's get going! I have so much planned for us to do", preferredStyle: .Alert)
            alertController.addAction(UIAlertAction(title: "Let's go", style: .Default, handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
                
            } else {
                // userMessage = error!.localizedDescription
                
                let alertController = UIAlertController(title: "Problem", message: userMessage, preferredStyle: .Alert)
                alertController.addAction(UIAlertAction(title: "Couldn't login", style: .Default, handler: nil))
                self.presentViewController(alertController, animated: true, completion: nil)

            }
            
            
        }
        
   
    }

    
    
    

}

