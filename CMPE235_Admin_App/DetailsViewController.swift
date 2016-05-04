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
    
    @IBOutlet weak var tableView: UITableView!
    var location:String! = nil
    var id :String! = nil
    var statusImage: UIImage! = nil
    
    var visitorsRecord:[VisitorsCount] = []
    
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
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        loadSimpleDataFromParse()
        tableView?.dataSource = self
        tableView?.reloadData()   // ...and it is also visible here.
    }
    
    
    func loadSimpleDataFromParse(){
        let today = NSDate()
        let day_1_Query = PFQuery(className:"ProximitySensorRecord")
        //day_1_Query.whereKey("createdAt", greaterThanOrEqualTo: daysFromNow_1)
        day_1_Query.whereKey("createdAt", lessThanOrEqualTo: today)
        
        
        day_1_Query.findObjectsInBackgroundWithBlock {
            (results: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                
                let visitorCount = VisitorsCount()
                visitorCount.count = Int((results?.count)!)
                visitorCount.date = self.getFormatedDate(today)
                self.visitorsRecord.append(visitorCount)
                self.tableView?.reloadData()
                
            }        }
        
        
        
        
        
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
        
        var day_1_Query = PFQuery(className:"ProximitySensorRecord")
        day_1_Query.whereKey("createdAt", greaterThanOrEqualTo: daysFromNow_1)
        day_1_Query.whereKey("createdAt", lessThan: today)
        
        var day_2_Query = PFQuery(className:"ProximitySensorRecord")
        day_2_Query.whereKey("createdAt", greaterThanOrEqualTo: daysFromNow_2)
        day_2_Query.whereKey("createdAt", lessThan: daysFromNow_1)
        
        var day_3_Query = PFQuery(className:"ProximitySensorRecord")
        day_3_Query.whereKey("createdAt", greaterThanOrEqualTo: daysFromNow_3)
        day_3_Query.whereKey("createdAt", lessThan: daysFromNow_2)
        
        day_1_Query.countObjectsInBackgroundWithBlock {
            (count: Int32, error: NSError?) -> Void in
            if error == nil {
                print("Todays visitors  - \(count) ")
                let visitorCount = VisitorsCount()
                visitorCount.count = Int(count)
                visitorCount.date = self.getFormatedDate(today)
                self.visitorsRecord.append(visitorCount)
            }
            day_2_Query.countObjectsInBackgroundWithBlock({ (count: Int32, error: NSError?) in
                if error == nil {
                    print("Yesterdays visitors  - \(count) ")
                    let visitorCount = VisitorsCount()
                    visitorCount.count = Int(count)
                    visitorCount.date = self.getFormatedDate(today)
                    self.visitorsRecord.append(visitorCount)
                }
                
                }
            )
            day_3_Query.countObjectsInBackgroundWithBlock({ (count : Int32, error : NSError?) in
                if error == nil {
                    print("day before yesterday visitors  - \(count) ")
                    let visitorCount = VisitorsCount()
                    visitorCount.count = Int(count)
                    visitorCount.date = self.getFormatedDate(today)
                    self.visitorsRecord.append(visitorCount)
                    
                }
            })
            
            
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
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.visitorsRecord.count
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCellWithIdentifier("VisitorsRecordCell", forIndexPath: indexPath) as! VisitorsRecordCell
        
        let record = self.visitorsRecord[indexPath.row]
        
        cell.dateLabel.text = record.date
        cell.visitors.text = String(record.count)
        return cell
    }
    
    
    func getFormatedDate(date:NSDate) -> String{
        let dateformatter = NSDateFormatter()
        dateformatter.dateStyle = NSDateFormatterStyle.MediumStyle
        dateformatter.timeStyle = NSDateFormatterStyle.MediumStyle
        
        return dateformatter.stringFromDate(date)
    }
    
    
}

class VisitorsCount{
    var count:Int = 0
    var date:String = ""
    
}
