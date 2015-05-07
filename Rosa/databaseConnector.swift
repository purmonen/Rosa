//
//  databaseConnector.swift
//  Rosa
//
//  Created by Paul Griffin on 07/05/15.
//  Copyright (c) 2015 Sami Purmonen. All rights reserved.
//

import Foundation

class databaseConnector{
    let database = "teamrosa"
    let collection = "readings"
    var url: String {
        return "https://api.mongolab.com/api/1/databases/\(database)/collections/\(collection)?apiKey=VEtCU0LBaYtnDP51KNliwetFRtjywjNl"
    }
    
    func getAllReadings()->AnyObject?{
        let request = NSURLRequest(URL: NSURL(string: url)!)
        var response:NSURLResponse? = NSURLResponse()
        var data = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: nil)
        
        if (data == nil){
            return nil
        }
//        NSLog(NSString(data: data!, encoding: NSUTF8StringEncoding) as! String)
        return NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: nil)
    }
    /*func AddReading(){
        var request = NSMutableURLRequest(URL: NSURL(string: url)!)
        request.HTTPMethod = "POST"
        let bodyDictionary = []
        let requestData = NSJSONSerialization.dataWithJSONObject(bodyDictionary, options: nil, error: nil)
        request.HTTPBody = NSString(data: requestData, encoding: NSUTF8StringEncoding)
        
        var response:NSURLResponse? = NSURLResponse()
        var data = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: nil)
        
    }*/
    
}