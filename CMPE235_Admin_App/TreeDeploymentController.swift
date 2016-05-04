//
//  TreeDeploymentController.swift
//  CMPE235_Admin_App
//
//  Created by Shrutee Gangras on 5/3/16.
//  Copyright © 2016 Shrutee Gangras. All rights reserved.
//

import UIKit
import Parse

class TreeDeploymentController: UIViewController {
    
    var treeId:String!
    
    @IBOutlet weak var treeID: UITextField!
    @IBOutlet weak var installedDate: UITextField!
    @IBOutlet weak var Location: UITextField!
    
    @IBOutlet weak var status: UISwitch!
    
    
    @IBAction func deployTree(sender: AnyObject) {
        
        let deploy = PFObject(className: "TreeDeployment")
        deploy["TreeId"] = treeID.text
        deploy["Location"] = Location.text
        
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
                // self.reset()
                
                
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
        treeID.text = ""
        installedDate.text = ""
        Location.text = ""
        status.on = true
        
    }
    
    
}



