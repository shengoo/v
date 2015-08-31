//
//  Movie.swift
//  vis
//
//  Created by Qing Sheng on 15/7/27.
//  Copyright (c) 2015年 Sheng Qing. All rights reserved.
//

import Foundation


class Movie : NSObject, NSCoding {
    var id:Int
    var title:String
    var desc:String
    var date:String
    var category:String
    var length:Int
    var image:String
    var video:String
    
    init(id:Int,title:String,desc:String,date:String,category:String,length:Int,image:String,video:String){
        self.id = id
        self.title = title
        self.desc = desc
        self.date = date
        self.category = category
        self.length = length
        self.image = image
        self.video = video
    }
    
    func encodeWithCoder(aCoder: NSCoder){
        aCoder.encodeInteger(self.id, forKey: "id")
        aCoder.encodeObject(self.title, forKey: "title")
        aCoder.encodeObject(self.desc, forKey: "desc")
        aCoder.encodeObject(self.date, forKey: "date")
        aCoder.encodeObject(self.category, forKey: "category")
        aCoder.encodeInteger(self.length, forKey: "length")
        aCoder.encodeObject(self.image, forKey: "image")
        aCoder.encodeObject(self.video, forKey: "video")
    }
    required init(coder aDecoder: NSCoder){
        self.id = aDecoder.decodeIntegerForKey("id")
        self.title = aDecoder.decodeObjectForKey("title") as! String
        self.desc = aDecoder.decodeObjectForKey("desc") as! String
        self.date = aDecoder.decodeObjectForKey("date") as! String
        self.category = aDecoder.decodeObjectForKey("category") as! String
        self.length = aDecoder.decodeIntegerForKey("length")
        self.image = aDecoder.decodeObjectForKey("image") as! String
        self.video = aDecoder.decodeObjectForKey("video") as! String
    }
}