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
    var url2: String {
        return "https://api.mongolab.com/api/1/databases/\(database)/runCommand?apiKey=VEtCU0LBaYtnDP51KNliwetFRtjywjNl"
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
    func getAllSensors()->AnyObject?{

        let request = NSMutableURLRequest(URL: NSURL(string: url2)!)
        request.HTTPMethod = "POST"
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(["distinct":collection, "key":"ip", "query": [:]], options: nil, error: nil);
        request.setValue("application/json", forHTTPHeaderField: "Content-type")
        var response:NSURLResponse? = NSURLResponse()
        var data = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: nil)
        
        if (data == nil){
            return nil
        }
        //        NSLog(NSString(data: data!, encoding: NSUTF8StringEncoding) as! String)
        var result :AnyObject? =  NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: nil)
        var out = [AnyObject]();
        if let ips = (result as? [String:AnyObject])?["values"] as? [String]{
            for ip in ips {
                var theurl:String? = url+"&q={\"ip\":\"\(ip)\"}&s={\"timestamp\":-1}&l=1"
                theurl = theurl?.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
                let request = NSMutableURLRequest(URL: NSURL(string: theurl!)!)
                var response:NSURLResponse? = NSURLResponse()
                var data = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: nil)

                var result =  NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: nil)
                //println(result)
                out.append(result![0])
                
            }
        }
        return out
    }
    func getAllTemperaturesForIp(ip:String)->[Double]{
        var theurl:String? = url+"&q={\"ip\":\"\(ip)\"}&f={\"temp\":1, \"timestamp\":1}"
        theurl = theurl?.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
println(theurl)
        let request = NSURLRequest(URL: NSURL(string: theurl!)!)
        var response:NSURLResponse? = NSURLResponse()
        var data = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: nil)
        
        if (data == nil){
            return []
        }
        //return NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: nil)
        if let var json = NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: nil) as? [[String:AnyObject]] {
            return json.map({$0["temp"]! as! Double})
        }
        return []
    }
   
    
}