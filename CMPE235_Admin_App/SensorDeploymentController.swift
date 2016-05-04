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
        
        deploy["updatedAt"] = installedDate.text
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
    
    func reset()
    {
        senorIDTField.text = ""
        deployTreeID.text = ""
        date.text = ""
        status.on = true
        
    }
    
}
