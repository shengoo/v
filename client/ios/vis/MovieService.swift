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
    
    func addShoucang(movie:Movie){
        let list = Defaults["sc"].arrayValue
        var newlist:NSMutableArray = NSMutableArray(array: list)
        var data = NSKeyedArchiver.archivedDataWithRootObject(movie)
        newlist.addObject(data)
        Defaults["sc"] = newlist
        
    }
    func deleteShoucang(movie:Movie){
        let list = Defaults["sc"].arrayValue
        var newlist:NSMutableArray = NSMutableArray(array: list)
        for item in list{
            var a = NSKeyedUnarchiver.unarchiveObjectWithData(item as! NSData) as! Movie
            if(a.id == movie.id){
                newlist.removeObject(item)
            }
        }
        Defaults["sc"] = newlist
    }
    func checkShoucang(movie:Movie)->Bool{
        var result = false
        let list = Defaults["sc"].arrayValue
        for item in list{
            var a = NSKeyedUnarchiver.unarchiveObjectWithData(item as! NSData) as! Movie
            if(a.id == movie.id){
                return true
            }
        }
        return result
    }
    func getShoucang()->[Movie]{
        let list = Defaults["sc"].arrayValue
//        let result:NSMutableArray = NSMutableArray()
        var result = [Movie]()
        for item in list{
            var a = NSKeyedUnarchiver.unarchiveObjectWithData(item as! NSData) as! Movie
//            result.addObject(a)
            result.append(a)
        }
        return result
    }
    
    
    func addHuancun(movie:Movie){
        let list = Defaults["hc"].arrayValue
        var newlist:NSMutableArray = NSMutableArray(array: list)
        var data = NSKeyedArchiver.archivedDataWithRootObject(movie)
        newlist.addObject(data)
        Defaults["hc"] = newlist
        DownloadHandler.download(movie)
        println("start download:http://182.92.153.230/file/" + movie.video)
    }
    func deleteHuancun(movie:Movie){
        let list = Defaults["hc"].arrayValue
        var newlist:NSMutableArray = NSMutableArray(array: list)
        for item in list{
            var a = NSKeyedUnarchiver.unarchiveObjectWithData(item as! NSData) as! Movie
            if(a.id == movie.id){
                newlist.removeObject(item)
            }
        }
        Defaults["hc"] = newlist
        DownloadHandler.deleteMovie(movie)
    }
    func checkHuancun(movie:Movie)->Bool{
        var result = false
        let list = Defaults["hc"].arrayValue
        for item in list{
            var a = NSKeyedUnarchiver.unarchiveObjectWithData(item as! NSData) as! Movie
            if(a.id == movie.id){
                return true
            }
        }
        return result
    }
    func getHuancun()->[Movie]{
        let list = Defaults["hc"].arrayValue
        var result = [Movie]()
        for item in list{
            var a = NSKeyedUnarchiver.unarchiveObjectWithData(item as! NSData) as! Movie
            result.append(a)
        }
        return result
    }
    
    
    func checkImageFile(movie:Movie)->Bool{
        var imageFile = DownloadHandler.getImageUrl(movie)
        var checkValidation = NSFileManager.defaultManager()
        return checkValidation.fileExistsAtPath(imageFile.path!)
    }
    
    func checkVideoFile(movie:Movie) -> Bool{
        var videoFile = DownloadHandler.getVideoUrl(movie)
        var checkValidation = NSFileManager.defaultManager()
        return checkValidation.fileExistsAtPath(videoFile.path!)
        
    }
    
    
}