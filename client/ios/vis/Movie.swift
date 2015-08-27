//
//  Movie.swift
//  vis
//
//  Created by Qing Sheng on 15/7/27.
//  Copyright (c) 2015年 Sheng Qing. All rights reserved.
//

import Foundation


class Movie {
    var id:Int
    var title:String
    var description:String
    var date:String
    var category:String
    var length:Int
    var image:String
    var video:String
    
    init(id:Int,title:String,desc:String,date:String,category:String,length:Int,image:String,video:String){
        self.id = id
        self.title = title
        self.description = desc
        self.date = date
        self.category = category
        self.length = length
        self.image = image
        self.video = video
    }
    
}