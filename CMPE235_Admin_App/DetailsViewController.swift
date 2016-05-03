//
//  TreeDetailsViewController.swift
//  CMPE235_Admin_App
//
//  Created by Shrutee Gangras on 5/3/16.
//  Copyright © 2016 Shrutee Gangras. All rights reserved.
//

import UIKit
import Parse

class DetailsViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var location:String! = nil
    var id :String! = nil
    var statusImage: UIImage! = nil
    
    var
    
    @IBOutlet weak var idTitleLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!


    @IBOutlet weak var idLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        if(location != nil){
            locationLabel.text = location
        }
        if(id != nil){
            idLabel.text = id
        }
        if(statusImage != nil){
            imageView.image = statusImage
        }
        
        loadDataFromParse()
        
    }
    
    func loadDataFromParse(){
        let today = NSDate()
        
        let daysFromNow_1 = NSCalendar.currentCalendar().dateByAddingUnit(
            [.Day],
            value: -1,
            toDate: today,
            options: [])!
        
        let daysFromNow_2 = NSCalendar.currentCalendar().dateByAddingUnit(
            [.Day],
            value: -2,
            toDate: today,
            options: [])!
        
        let daysFromNow_3 = NSCalendar.currentCalendar().dateByAddingUnit(
            [.Day],
            value: -3,
            toDate: today,
            options: [])!
        
        var query = PFQuery(className:"ProximitySensorRecord")
        query.whereKey("createdAt", greaterThanOrEqualTo: yesterday)
        query.whereKey("createdAt", lessThan: today)
        
        
    }
    
    
    
}

class VisitorsCount{
    var count:Int = 0
    var data:NSDate = NSDate()

}
