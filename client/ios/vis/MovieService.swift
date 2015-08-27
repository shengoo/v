//
//  MovieService.swift
//  vis
//
//  Created by Qing Sheng on 15/7/27.
//  Copyright (c) 2015年 Sheng Qing. All rights reserved.
//

import Foundation

class MovieService {
    
    
    var settings:Settings
    var manager:AFHTTPRequestOperationManager
    
    
    init(){
        self.settings = Settings()
        self.manager = AFHTTPRequestOperationManager()
        manager.requestSerializer = AFJSONRequestSerializer()
        manager.responseSerializer = AFJSONResponseSerializer()
    }
    
    func getAll(callback:(NSArray)->()){
        request(settings.all, callback: callback)
    }
    
    func getCategory(callback:(NSArray)->()){
        request(settings.category, callback: callback)
    }
    
    func getByCategory(category:String,callback:(NSArray)->()){
        var str = "http://182.92.153.230/api/getmoviebycategory/" + category
        request(str, callback: callback)
    }

    
    func request(url:String,callback:(NSArray)->()){
        var nsurl = url.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        manager.GET(nsurl,
            parameters: nil,
            success: { (oper, data) -> Void in
//                print(data)
                callback(data as! NSArray)
            },
            failure: { (opeation, error) -> Void in
                println(error)
            }
        )
        
//        println(callback)
//        let task = NSURLSession.sharedSession().dataTaskWithURL(nsurl!, completionHandler: {
//            (data,response,error) in
//            var error:NSError?
//            var response = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &error) as! NSArray
//            callback(response)
//        })
//        task.resume()
    }
    
}