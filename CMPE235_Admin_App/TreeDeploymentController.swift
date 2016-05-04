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
    
    
    override func viewDidLoad() {
       
        if(self.treeId != nil ){
            let query = PFQuery(className: "TreeRegistration")
            query.whereKey("TreeId", equalTo: treeId)
            query.findObjectsInBackgroundWithBlock {
                (results: [PFObject]?, error: NSError?) -> Void in
                if error == nil {
                    if(results?.count>0){
                        var tree = results![0]
                        if(tree["Installed"] as! Bool == true){
                            let deploymentQuery = PFQuery(className: "Deployment")
                            
                        }
                    
                    }
                    
                    
               
            }

        }
        
    }
    
}
