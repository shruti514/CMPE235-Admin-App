//
//  SplashScreen.swift
//  CMPE235_Admin_App
//
//  Created by Shrutee Gangras on 5/2/16.
//  Copyright © 2016 Shrutee Gangras. All rights reserved.
//

import UIKit
import Parse


class SplashScreen: UIViewController {

    @IBOutlet weak var greetingLable: UILabel!
    
    
    @IBOutlet weak var nameLabel: UILabel!
    
    
    override func viewWillAppear(animated: Bool) {
        if (PFUser.currentUser() == nil) {
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                let viewController = self.storyboard?.instantiateViewControllerWithIdentifier("LoginController") as! LoginController
                
                self.presentViewController(viewController, animated: true, completion: nil)
            })
        }
        else{
            let user = PFUser.currentUser()
            if(user?.username != nil){
                self.greetingLable.hidden = false
                self.nameLabel.hidden = false
                self.nameLabel.text = user?.username
            }
        }
    }
    
    
    
}
