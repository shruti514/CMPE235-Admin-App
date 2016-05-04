//
//  SensorDeploymentController.swift
//  CMPE235_Admin_App
//
//  Created by Shrutee Gangras on 5/3/16.
//  Copyright © 2016 Shrutee Gangras. All rights reserved.
//

import UIKit

class SensorDeploymentController: UIViewController {

    var sensorId:String!
    
    @IBOutlet weak var senorIDTField: UITextField!
    
    @IBOutlet weak var deployTreeID: UITextField!
    
    
    @IBOutlet weak var date: UITextField!
    
    
    @IBOutlet weak var status: UISwitch!
    
   
    
    @IBAction func deploySensor(sender: AnyObject) {
        let deploy = PFObject(className: "SensorDeployment")
        deploy["SensorId"] = senorIDTField.text
        deploy["TreeId"] = deployTreeID.text
        
       // deploy["updatedAt"] = installedDate.text
        deploy["Status"] = status.on
        
        
        deploy.saveInBackgroundWithBlock {(success:Bool, error:NSError?) in
            if (success) {
                print("Deployment record saved to database")
                let alert = UIAlertController(title: "Success", message: "Deployment Successful", preferredStyle: UIAlertControllerStyle.Alert)
                
                alert.addAction(UIAlertAction(title: "Done", style: .Cancel, handler: { action in print("Pass Alert Shown")}))
                
                self.presentViewController(alert, animated: true, completion: nil)
                self.reset()
                
            } else {
                
                print("Error")
                let alert = UIAlertController(title: "Failed", message: "Deployment Unsuccessful", preferredStyle: UIAlertControllerStyle.Alert)
                
                alert.addAction(UIAlertAction(title: "Done",
                    style: UIAlertActionStyle.Default,
                    handler: {(alert: UIAlertAction!) in print("Fail Alert Shown")}))
                self.presentViewController(alert, animated: true, completion: nil)
                self.reset()
                

                
            }
        }

        
        
    }
    
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

    
    func reset()
    {
        senorIDTField.text = ""
        deployTreeID.text = ""
        date.text = ""
        status.on = true
        
    }
    
}
