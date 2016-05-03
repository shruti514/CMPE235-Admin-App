//
//  SmartThings.swift
//  CMPE235_Admin_App
//
//  Created by Shrutee Gangras on 5/2/16.
//  Copyright © 2016 Shrutee Gangras. All rights reserved.
//


import UIKit

class SmartThings {
    
    var id:String
    var status:Bool!
    var location: String!
    
    init(id:String){
        self.id = id
    }
    
}


class SmartTrees: SmartThings {
    
    override init(id:String){
        super.init(id: id)
    }
    
}


class Sensors: SmartThings {
    
    var treeId:String!
    
    override init(id:String){
        super.init(id: id)
    }
    
}

