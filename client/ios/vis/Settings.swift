//
//  Settings.swift
//  vis
//
//  Created by Qing Sheng on 15/7/27.
//  Copyright (c) 2015年 Sheng Qing. All rights reserved.
//

import UIKit

class Settings: NSObject {
    
    var root = "http://182.92.153.230/"
    var today = "http://182.92.153.230/api/today"
    var category = "http://182.92.153.230/api/category"
    var all = "http://182.92.153.230/api"
    
    
    static func shouldAlert()-> Bool{
        return Defaults["shouldAlert"].boolValue
    }
    
    static func setWifiAlert(val:Bool){
        Defaults["shouldAlert"] = val
    }
    
    static func shouldAutoCache()->Bool{
        return Defaults["shouldAutoCache"].boolValue
    }
    
    static func setAutoCache(val:Bool){
        Defaults["shouldAutoCache"] = val
    }
   
}
