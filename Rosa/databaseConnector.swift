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
    
    func getAllSensors()->[AnyObject] {
        let request = NSMutableURLRequest(URL: NSURL(string: url2)!)
        request.HTTPMethod = "POST"
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(["distinct":collection, "key":"ip", "query": [:]], options: nil, error: nil)
        request.setValue("application/json", forHTTPHeaderField: "Content-type")
        var response: NSURLResponse? = nil
        var out = [AnyObject]();
        if let data = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: nil),
            let result: AnyObject =  NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil),
            let ips = (result as? [String:AnyObject])?["values"] as? [String] {
                for ip in ips {
                    if let theurl = (url+"&q={\"ip\":\"\(ip)\"}&s={\"timestamp\":-1}&l=1").stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding) {
                        let request = NSMutableURLRequest(URL: NSURL(string: theurl)!)
                        var response:NSURLResponse? = nil
                        if let data = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: nil),
                            let result = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as? [AnyObject] where !result.isEmpty {
                                out.append(result[0])
                                
                        }
                    }
                    
                }
        }
        return out
    }
    
    func getAllTemperaturesForIp(ip:String)->[Double]{
        if let theurl = (url+"&q={\"ip\":\"\(ip)\"}&f={\"temp\":1, \"timestamp\":1}").stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding) {
            let request = NSURLRequest(URL: NSURL(string: theurl)!)
            var response:NSURLResponse? = nil
            if let data = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: nil) {
                if let json = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as? [[String:AnyObject]] {
                    return json.map({$0["temp"] as? Double ?? 0.0})
                }
            }
        }
        return []
    }
    
    
}