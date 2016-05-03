//
//  MonitorViewController.swift
//  CMPE235_Admin_App
//
//  Created by Shrutee Gangras on 5/3/16.
//  Copyright © 2016 Shrutee Gangras. All rights reserved.
//

//

import UIKit
import Parse

class MonitorViewController: UITableViewController {
    
    @IBAction func goToHome(sender: AnyObject) {
        let menuView = storyboard?.instantiateViewControllerWithIdentifier("MenuView") as! MenuViewController
        menuView.modalPresentationStyle = .OverCurrentContext
    }
    
    
    @IBAction func detailsButtonPushed(sender: AnyObject) {
        
        
    }    
    
    var records : [MonitoringRecords]=[]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadRecords()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return records.count
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.records[section].records.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("MonitorTableCell", forIndexPath: indexPath) as! MonitorTableViewCell
        
        let section = records[indexPath.section]
        let smartThing = section.records[indexPath.row]
        
        if(indexPath.section == 0){
            cell.idLabel.text = "Tree ID: "+smartThing.id
            
        }
        if(indexPath.section == 1){
            cell.idLabel.text = "Sensor ID: "+smartThing.id
            
        }
        if(smartThing.status == true){
            cell.statusImage.image = UIImage(named: "Photo")
        }else{
            cell.statusImage.image = UIImage(named: "About")
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = records[section]
        return section.recordType
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let section = records[indexPath.section]
        if(indexPath.section == 0 ){
            let smartTree = section.records[indexPath.row] as! SmartTrees
            
            showTreeDetailsView(smartTree)
        }
        if(indexPath.section == 1){
            let sensor = section.records[indexPath.row] as! Sensors
            
            showSensorDetailsView(sensor)
        }
        
    }
    
    func showTreeDetailsView(tree:SmartTrees){
        let detailView = storyboard?.instantiateViewControllerWithIdentifier("DetailsViewController") as! DetailsViewController
        detailView.modalPresentationStyle = .OverCurrentContext
    
        
        detailView.id = tree.id
        detailView.location = tree.location
        if(tree.status == true){
            detailView.statusImage = UIImage(named:"Photo")
        }else{
            detailView.statusImage = UIImage(named:"About")
        }
        
        self.presentViewController(detailView, animated: true, completion: nil)
    }
    
    func showSensorDetailsView(sensor:Sensors){
        let detailView = storyboard?.instantiateViewControllerWithIdentifier("DetailsViewController") as! DetailsViewController
        detailView.modalPresentationStyle = .OverCurrentContext
        
        detailView.id = sensor.id
        detailView.location = sensor.location
        if(sensor.status == true){
            detailView.statusImage = UIImage(named:"Photo")
        }else{
            detailView.statusImage = UIImage(named:"About")
        }
        
        self.presentViewController(detailView, animated: true, completion: nil)
    }
    
    
    func loadRecords(){
        self.fetchTreeRecords()
    }
    
    private  func fetchTreeRecords(){
        var records:[SmartThings]=[]
        
        let query = PFQuery(className: "TreeDeployment")
        query.orderByAscending("TreeId")
        query.findObjectsInBackgroundWithBlock {
            (results: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                for tree in results!{
                    let id = tree["TreeId"] as! String
                    let smartThing = SmartTrees(id:id)
                    smartThing.status = tree["Status"] as! Bool
                    smartThing.location = tree["Location"] as! String
                    records.append(smartThing)
                }
            }
            if(self.records.count >= 2){
                self.records[0] = MonitoringRecords(recordType: "Tree Monitoring", records: records)
            }else{
                self.records.append(MonitoringRecords(recordType: "Tree Monitoring", records: records))
            }
            
            self.fetchSensorRecords()
        }
    }
    
    private  func fetchSensorRecords(){
        var records:[SmartThings]=[]
        
        let query = PFQuery(className: "SensorDeployment")
        // query.whereKey("TreeId", equalTo: tree.id)
        query.orderByAscending("SensorId")
        query.findObjectsInBackgroundWithBlock {
            (results: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                for sensor in results!{
                    let id = sensor["SensorId"] as! String
                    
                    let smartThing = Sensors(id:id)
                    smartThing.treeId = sensor["TreeId"] as! String
                    smartThing.status = sensor["Status"] as! Bool
                    records.append(smartThing)
                }
            }
            if(self.records.count>=2){
                self.records[1]=(MonitoringRecords(recordType: "Sensor Monitoring", records: records))
            }else{
                self.records.append(MonitoringRecords(recordType: "Sensor Monitoring", records: records))
            }
            self.tableView.reloadData()
            
        }
    }
    
}

