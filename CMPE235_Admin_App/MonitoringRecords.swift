//
//  MonitoringRecords.swift
//  CMPE235_Admin_App
//
//  Created by Shrutee Gangras on 5/3/16.
//  Copyright © 2016 Shrutee Gangras. All rights reserved.
//

import UIKit

class MonitoringRecords {
    
    var recordType:String
    var records:[SmartThings] = []
    
    init(recordType: String, records: [SmartThings]){
        self.recordType = recordType
        self.records = records
    }    

}
