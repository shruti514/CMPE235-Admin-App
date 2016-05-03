//
//  MenuViewController.swift
//  CMPE235_Admin_App
//
//  Created by Shrutee Gangras on 5/1/16.
//  Copyright © 2016 Shrutee Gangras. All rights reserved.
//
import UIKit

class MenuViewController: UIViewController {
    
    
    @IBAction func RegisterButtonPressed(sender: AnyObject) {
        
        let registrationModal = storyboard?.instantiateViewControllerWithIdentifier("RegistrationModal") as! RegistrationModal
        registrationModal.modalPresentationStyle = .OverCurrentContext
        
        self.presentViewController(registrationModal, animated: true, completion: nil)
        
    }
    
    

}
