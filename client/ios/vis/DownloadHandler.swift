//
//  DownloadHandler.swift
//  vis
//
//  Created by Qing Sheng on 15/9/5.
//  Copyright (c) 2015年 Sheng Qing. All rights reserved.
//

import Foundation

class DownloadHandler{
    
    static func download(movie:Movie){
        var configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        var manager = AFURLSessionManager()
        
        
        var videoUrl = "http://182.92.153.230/file/" + movie.video
        var imageUrl = "http://182.92.153.230/file/" + movie.image
        
        var videoRequest = NSURLRequest(URL: NSURL(string: videoUrl)!)
        var imageRequest = NSURLRequest(URL: NSURL(string: imageUrl)!)
        
        
        var op = AFHTTPRequestOperation(request: imageRequest)
        var path = self.getImageUrl(movie).path
        if(!NSFileManager.defaultManager().fileExistsAtPath(path!)){
            op.outputStream = NSOutputStream(toFileAtPath: path!, append: false)
            op.setCompletionBlockWithSuccess({ op, xx in
                println("image downloaded: \(path)")
                }, failure: { op,err in
                    println("image download error:\(err.description)")
            })
            op.start()
        }
        
        var videoOp = AFHTTPRequestOperation(request: videoRequest)
        var videopath = self.getVideoUrl(movie).path
        if(!NSFileManager.defaultManager().fileExistsAtPath(videopath!)){
            videoOp.outputStream = NSOutputStream(toFileAtPath: videopath!, append: false)
            videoOp.setCompletionBlockWithSuccess({ op, xx in
                println("video downloaded: \(videopath)")
                }, failure: { op,err in
                    println("video download error:\(err.description)")
            })
            videoOp.start()
        }
        
    }
    
    static func getVideoUrl(movie:Movie) -> NSURL{
        var root = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
        var filtpath = root.stringByAppendingPathComponent(movie.video)
        return  NSURL(string: filtpath)!
    }
    
    static func getImageUrl(movie:Movie) -> NSURL{
        var root = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
        var filtpath = root.stringByAppendingPathComponent(movie.image)
        return  NSURL(string: filtpath)!
    }
    
    static func listFiles(){
        let fileManager = NSFileManager.defaultManager()
        let enumerator:NSDirectoryEnumerator = fileManager.enumeratorAtPath(NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String)!
        
        while let element = enumerator.nextObject() as? String {
            println(element)
        }
    }
    
    static func deleteMovie(movie:Movie){
        var imagePath = self.getImageUrl(movie).path!
        if(NSFileManager.defaultManager().fileExistsAtPath(imagePath)){
            NSFileManager.defaultManager().removeItemAtPath(imagePath, error: nil)
        }
        
        var videoPath = self.getVideoUrl(movie).path!
        if(NSFileManager.defaultManager().fileExistsAtPath(videoPath)){
            NSFileManager.defaultManager().removeItemAtPath(videoPath, error: nil)
        }
    }
    
    
    static func startAutoCache(){
        if(Settings.shouldAutoCache() && IJReachability.isConnectedToNetworkOfType() == IJReachabilityType.WiFi){
            var service = MovieService()
            var list = service.getShoucang()
            for item in list{
                self.download(item)
            }
        }
    }
    
    static func clearCache(){
        Defaults["hc"] = nil
        let fileManager = NSFileManager.defaultManager()
        let enumerator:NSDirectoryEnumerator = fileManager.enumeratorAtPath(NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String)!
        while let element = enumerator.nextObject() as? String {
            var root = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
            var path = root.stringByAppendingPathComponent(element)
            NSFileManager.defaultManager().removeItemAtPath(path, error: nil)
        }
        
    }
    
    
}