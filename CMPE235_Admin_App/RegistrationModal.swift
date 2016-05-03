//
//  RegistrationModal.swift
//  CMPE235_Admin_App
//
//  Created by Shrutee Gangras on 5/2/16.
//  Copyright © 2016 Shrutee Gangras. All rights reserved.
//
import UIKit

class RegistrationModal: UIViewController {
    
    @IBAction func registerTree(sender: AnyObject) {
        let registerTree = storyboard?.instantiateViewControllerWithIdentifier("RegisterTree") as! RegisterTree
        registerTree.modalPresentationStyle = .OverCurrentContext
        
    }
    
    
    @IBAction func registerSensor(sender: AnyObject) {
        
        let registerSensor = storyboard?.instantiateViewControllerWithIdentifier("RegisterSensor") as! RegisterSensor
        registerSensor.modalPresentationStyle = .OverCurrentContext
        
    }
    
    
    
}
