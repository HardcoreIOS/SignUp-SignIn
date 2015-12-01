//
//  SignUpViewController.swift
//  Signup
//
//  Created by Abdurrahman on 11/24/15.
//  Copyright © 2015 Hardcore IOS. All rights reserved.
//

import UIKit
import Parse

class SignUpViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var signUpOutlet: UIButton!
    @IBOutlet weak var profilePhotoImageView: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    
    // Password: ------------------------------
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    // END Password: ------------------------------
    
    // FirstName and LastName: ------------------------------
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    // END of FirstName and LastName: ------------------------------
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        self.postImage.layer.cornerRadius = postImage.frame.size.width / 2
        postImage.clipsToBounds = true
        */
        
        // Round Stuff Up: ------------------------------
        self.signUpOutlet.layer.cornerRadius = 15
        profilePhotoImageView.layer.cornerRadius = profilePhotoImageView.frame.size.width/2
        profilePhotoImageView.clipsToBounds = true
        // END: --------------------------------
        
        self.view.endEditing(true)
        
    }

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        profilePhotoImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
     
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
	
    @IBAction func cancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func selectProfileButtonTapped(sender: AnyObject) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(imagePicker, animated: true, completion: nil)
        
    }
    
    @IBAction func signUpPressed(sender: AnyObject) {
        
        self.view.endEditing(true)
        
        let userName = emailTextField.text
        let password = passwordTextField.text
        let repeatPassword = repeatPasswordTextField.text
        let firstName = firstNameTextField.text
        let lastName = lastNameTextField.text
        
        
        if (emailTextField.text == "" || emailTextField.text == nil || passwordTextField.text == "" || passwordTextField.text == nil || repeatPasswordTextField.text == "" || passwordTextField.text == nil || repeatPasswordTextField.text == "" || repeatPasswordTextField.text == nil || firstNameTextField.text == "" || firstNameTextField.text == nil || lastNameTextField.text == "" || lastNameTextField.text == nil) {
            
            let alertController = UIAlertController(title: "Oops", message: "All text fields must be filled", preferredStyle: .Alert)
            alertController.addAction(UIAlertAction(title: "ok!", style: .Default, handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
            
            return
        }
        
        if repeatPasswordTextField.text != passwordTextField.text {
            
            let alertController = UIAlertController(title: "Error", message: "The passwords you have entered do not match, please try again later", preferredStyle: .Alert)
            alertController.addAction(UIAlertAction(title: "ok!", style: .Default, handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
            
            return
        }
        
        var imageData = UIImageJPEGRepresentation(profilePhotoImageView.image!, 1)
        
        if let profileImage = profilePhotoImageView.image {
            
            imageData = UIImageJPEGRepresentation(profileImage,1)
            
        } else {
            let alertController = UIAlertController(title: "Error", message: "Please choose an Image for your profile", preferredStyle: .Alert)
            alertController.addAction(UIAlertAction(title: "ok!", style: .Default, handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        
        
        
        let user: PFUser = PFUser()
        user.username = userName
        user.password = password
        user.email = userName
        
        user.setObject(firstName!, forKey: "first_name")
        user.setObject(lastName!, forKey: "last_name")
        
        if imageData != nil {
            
            let profileImageFile = PFFile(data: imageData!)
            
            user.setObject(profileImageFile!, forKey: "profile_picture")
            
            
        } else {
            let alertController = UIAlertController(title: "Error", message: "Please choose an Image", preferredStyle: .Alert)
            alertController.addAction(UIAlertAction(title: "ok!", style: .Default, handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        
        
        user.signUpInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            
            var userMessage = "Registration was successfull. Thank You for signing up 👏"
        
            if !success {
                // userMessage = "Ooops, there was an error in signing up! Please try again"
                
                userMessage = error!.localizedDescription
            
            }
            
            let alertController = UIAlertController(title: "Success", message: "Registration was successful", preferredStyle: .Alert)
            alertController.addAction(UIAlertAction(title: "OK!", style: .Default, handler: { (alert: UIAlertAction) -> Void in
                
                if success {
                    
                    self.dismissViewControllerAnimated(true, completion: nil)
                
                }
                
            }))
            self.presentViewController(alertController, animated: true, completion: nil)

       
        
        }
    
    }// End of signUp Pressed
	
}
