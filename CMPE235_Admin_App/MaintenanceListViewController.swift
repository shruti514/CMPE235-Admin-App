//
//  MaintenanceListViewController.swift
//  CMPE235_Admin_App
//
//  Created by Shrutee Gangras on 5/1/16.
//  Copyright © 2016 Shrutee Gangras. All rights reserved.
//

import UIKit
import Parse

class MaintenanceListViewController: UITableViewController {

    
    var maitenanceRecords : [MaintenanceRecords]=[]
    
    
    var selectedTreeIndex : Int = 0
    
    override func viewDidLoad() {
        self.loadMaintenanceRecords()
        
    }
    
   
    
    @IBAction func updateButtonPressed(sender: AnyObject) {
        let point = tableView.convertPoint(CGPointZero, fromView: sender as! UIButton)
        if let indexPath = tableView.indexPathForRowAtPoint(point) {
            let section = maitenanceRecords[indexPath.section]
            if(indexPath.section == 0 ){
                let smartTree = section.records[indexPath.row] as! SmartTrees
                let treeId = smartTree.id
                showTreeDetailsView(treeId)
            }
            if(indexPath.section == 1){
                let sensor = section.records[indexPath.row] as! Sensors
                let sensorId = sensor.id
                showSensorDetailsView(sensorId)
            }
            
        }
        
    }
    
        
    @IBAction func barItemButtonPressed(sender: AnyObject) {
        if let menu = self.storyboard?.instantiateViewControllerWithIdentifier("MenuView") as? MenuViewController {
            
            
            self.presentViewController(menu, animated: true, completion: nil)
        }
    }
    
    @IBAction func deployButtonPressed(sender: AnyObject) {
        let point = tableView.convertPoint(CGPointZero, fromView: sender as! UIButton)
        if let indexPath = tableView.indexPathForRowAtPoint(point) {
            let section = maitenanceRecords[indexPath.section]
            if(indexPath.section == 0 ){
                let smartTree = section.records[indexPath.row] as! SmartTrees
                let treeId = smartTree.id
                navigateToTreeDeployment(treeId)
            }
            if(indexPath.section == 1){
                let sensor = section.records[indexPath.row] as! Sensors
                let sensorId = sensor.id
                navigateToSensorDeployment(sensorId)
            }
            
        }
        
    }
    
    
    func navigateToTreeDeployment(treeId:String){
        let treeDeployment = storyboard?.instantiateViewControllerWithIdentifier("TreeDeployment") as! TreeDeploymentController
        treeDeployment.modalPresentationStyle = .OverCurrentContext
        
        treeDeployment.treeId = treeId
        
        self.presentViewController(treeDeployment, animated: true, completion: nil)
        
        
    }
    
    
    func navigateToSensorDeployment(sensorId:String){
        let sensorDeployment = storyboard?.instantiateViewControllerWithIdentifier("SensorDeployment") as! SensorDeploymentController
        sensorDeployment.modalPresentationStyle = .OverCurrentContext
        
        sensorDeployment.sensorId = sensorId
        
        self.presentViewController(sensorDeployment, animated: true, completion: nil)
        
        
    }
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return maitenanceRecords.count
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return maitenanceRecords[section].records.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("MaintenanceTableCell", forIndexPath: indexPath) as! MaintenanceTableViewCell
        
        let section = maitenanceRecords[indexPath.section]
        let smartThing = section.records[indexPath.row]
        
        if(indexPath.section == 0){
            cell.titleLabel.text = "Tree ID: "+smartThing.id
            
        }
        if(indexPath.section == 1){
            cell.titleLabel.text = "Sensor ID: "+smartThing.id
            
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = maitenanceRecords[section]
        return section.recordType
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let section = maitenanceRecords[indexPath.section]
        if(indexPath.section == 0 ){
            let smartTree = section.records[indexPath.row] as! SmartTrees
            let treeId = smartTree.id
            showTreeDetailsView(treeId)
        }
        if(indexPath.section == 1){
            let sensor = section.records[indexPath.row] as! Sensors
            let sensorId = sensor.id
            showSensorDetailsView(sensorId)
        }
        
    }
    
    func showTreeDetailsView(treeId:String){
        let maintenanceDetailView = storyboard?.instantiateViewControllerWithIdentifier("MaintenanceDetailView") as! MaintenanceDetailViewController
        maintenanceDetailView.modalPresentationStyle = .OverCurrentContext
        
        let isTreeDetails = true
        
        maintenanceDetailView.treeId = treeId
        maintenanceDetailView.isTreeDetails = isTreeDetails
        self.presentViewController(maintenanceDetailView, animated: true, completion: nil)
    }
    
    func showSensorDetailsView(sensorId:String){
        let maintenanceDetailView = storyboard?.instantiateViewControllerWithIdentifier("MaintenanceDetailView") as! MaintenanceDetailViewController
        maintenanceDetailView.modalPresentationStyle = .OverCurrentContext
        
        var isTreeDetails = true
        if(sensorId != ""){
            isTreeDetails = false
        }
        
        maintenanceDetailView.sensorId = sensorId
        
        maintenanceDetailView.isTreeDetails = isTreeDetails
        
        self.presentViewController(maintenanceDetailView, animated: true, completion: nil)
    }
    
    func loadMaintenanceRecords(){
        self.fetchTreeRecords()
    }
    
    private  func fetchSensorRecords(forTree:SmartThings){
        var records:[SmartThings]=[]
        
        let query = PFQuery(className: "SensorRegistration")
        // query.whereKey("TreeId", equalTo: tree.id)
        query.orderByAscending("SensorId")
        query.findObjectsInBackgroundWithBlock {
            (results: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                for sensor in results!{
                    let id = sensor["SensorId"] as! String
                    
                    let smartThing = Sensors(id:id)
                    records.append(smartThing)
                }
            }
            if(self.maitenanceRecords.count>=2){
                self.maitenanceRecords[1]=(MaintenanceRecords(recordType: "Sensor Maintemance", records: records))
            }else{
                self.maitenanceRecords.append(MaintenanceRecords(recordType: "Sensor Maintemance", records: records))
            }
            self.tableView.reloadData()
            
        }
    }
    
    
    private  func fetchTreeRecords(){
        var records:[SmartThings]=[]
        
        let query = PFQuery(className: "TreeRegistration")
        query.orderByAscending("TreeId")
        query.findObjectsInBackgroundWithBlock {
            (results: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                for tree in results!{
                    let id = tree["TreeId"] as! String
                    let smartThing = SmartTrees(id:id)
                    records.append(smartThing)
                }
            }
            if(self.maitenanceRecords.count>=2){
                self.maitenanceRecords[0] = MaintenanceRecords(recordType: "Tree Maintemance", records: records)
            }else{
                self.maitenanceRecords.append(MaintenanceRecords(recordType: "Tree Maintemance", records: records))
            }
            
            self.fetchSensorRecords(records[self.selectedTreeIndex])
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

}
