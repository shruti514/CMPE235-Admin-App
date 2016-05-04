//
//  MenuViewController.swift
//  CMPE235_Admin_App
//
//  Created by Shrutee Gangras on 5/1/16.
//  Copyright © 2016 Shrutee Gangras. All rights reserved.
//
import UIKit

class MenuViewController: UIViewController {
    
    @IBAction func gotoHome(sender: AnyObject) {
        if let menu = self.storyboard?.instantiateViewControllerWithIdentifier("MenuView") as? MenuViewController {
            
            
            self.presentViewController(menu, animated: true, completion: nil)
        }
 
    }
    
    @IBAction func signout(sender: AnyObject) {
        // Send a request to log out a user
        PFUser.logOut()
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            if let loginview = self.storyboard?.instantiateViewControllerWithIdentifier("LoginController") as? LoginController {
                
                
                self.presentViewController(loginview, animated: true, completion: nil)
            }
            
        })
    }
    @IBAction func RegisterButtonPressed(sender: AnyObject) {
        
        let registrationModal = storyboard?.instantiateViewControllerWithIdentifier("RegistrationModal") as! RegistrationModal
        registrationModal.modalPresentationStyle = .OverCurrentContext
        
        self.presentViewController(registrationModal, animated: true, completion: nil)
        
    }
    
    

}
