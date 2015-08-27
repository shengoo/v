//
//  AppDelegate.swift
//  vis
//
//  Created by Qing Sheng on 15/7/20.
//  Copyright (c) 2015年 Sheng Qing. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func hidetab(){
        (self.window?.rootViewController as! UITabBarController).tabBar.hidden = true
    }
    
    func showtab(){
        (self.window?.rootViewController as! UITabBarController).tabBar.hidden = false
    }
    
    var umengKey = "55c32328e0f55ae881000579"

    var window: UIWindow?
//    var splashView: UIImageView?;


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
//        UIApplication.sharedApplication().statusBarStyle = .LightContent
        
        MobClick.startWithAppkey(umengKey)
        UMSocialData.setAppKey(umengKey)
        
        //CFBundleVersion for build version
        if let version = NSBundle.mainBundle().infoDictionary?["CFBundleShortVersionString"] as? String{
            MobClick.setAppVersion(version)
        }
        
        window?.makeKeyAndVisible()
        
        var splashView = UIImageView(frame: UIScreen.mainScreen().bounds)
        
        var background = UIImageView(frame: UIScreen.mainScreen().bounds)
        background.image = UIImage(named: "载入动画-图片")
        splashView.addSubview(background)
        
        window?.addSubview(splashView)
        window?.bringSubviewToFront(splashView)
        
        
        var wordx = UIScreen.mainScreen().bounds.width / 4;
        var wordy = UIScreen.mainScreen().bounds.height / 4;
        var wordw = UIScreen.mainScreen().bounds.width / 2;
        var wordh = UIScreen.mainScreen().bounds.height / 2;
        
        var word = UIImageView(image: UIImage(named: "logo"))
        word.center = splashView.center
        word.alpha = 0
        splashView.addSubview(word)
        
        
        
        var copyright = UIImageView(image: UIImage(named: "玖嘉公司名称"))
        var x:CGFloat, y:CGFloat;
        x = ( splashView.frame.size.width - copyright.frame.size.width) / 2;
        y = ( splashView.frame.size.height - copyright.frame.size.height - 32 );
        copyright.frame = CGRectMake(x, y, copyright.frame.size.width, copyright.frame.size.height)
        splashView.addSubview(copyright)
        
//        var font = UIFont(name: "SourceHanSansCN-Light", size: 17.0)
////        var text:NSString = "北京玖嘉国际传媒有限公司"
////        var labelSize = text.
//
//        var copyright = UILabel()
//        copyright.text = "- 北京玖嘉国际传媒有限公司 -"
//        copyright.font = font
//        copyright.textColor = UIColor.whiteColor()
//        copyright.sizeToFit()
//        var x:CGFloat, y:CGFloat;
//        x = ( splashView.frame.size.width - copyright.frame.size.width) / 2;
//        y = ( splashView.frame.size.height - copyright.frame.size.height - 32 );
//        copyright.frame = CGRectMake(x, y, copyright.frame.size.width, copyright.frame.size.height)
//        splashView.addSubview(copyright)
        
        
        UIView.animateWithDuration(4,
            delay: 0,
            options: UIViewAnimationOptions.CurveEaseOut,
            animations: {
                background.transform = CGAffineTransformMakeScale(1.2, 1.2)
            },
            completion: { _ in
                
            }
        )
//        UIView.animateWithDuration(2, delay: 2, options: .CurveLinear,
//            animations: {
//                background.transform = CGAffineTransformMakeScale(1, 1)
//            },
//            completion: { _ in
//                
//            }
//        )
        
        UIView.animateWithDuration(2, delay: 1, options: UIViewAnimationOptions.CurveLinear,
            animations: {
                word.alpha = 1
            },
            completion: { _ in
                
            }
        );
        
        UIView.animateWithDuration(1.2, delay: 4, options: UIViewAnimationOptions.CurveLinear,
            animations: {
                splashView.transform = CGAffineTransformMakeTranslation(-UIScreen.mainScreen().bounds.width, 0)
            },
            completion: { _ in
                splashView.removeFromSuperview()
            }
        );
        
        
        var tabBarController = self.window?.rootViewController as! UITabBarController
        tabBarController.hidesBottomBarWhenPushed = true
        var tabBar = tabBarController.tabBar
//        tabBar.backgroundImage = UIImage(named: "tabbg")
        
        

        
        let tabItems = tabBarController.tabBar.items as! [UITabBarItem]
        
        tabItems[0].image = UIImage(named: "leftu")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        
        tabItems[0].selectedImage = UIImage(named: "lefta")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        
        tabItems[1].image = UIImage(named: "rightu")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)

        tabItems[1].selectedImage = UIImage(named: "righta")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)


        
        return true
    }
    
    func application(application: UIApplication, handleOpenURL url: NSURL) -> Bool {
        return UMSocialSnsService.handleOpenURL(url)
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject?) -> Bool {
        return UMSocialSnsService.handleOpenURL(url)
    }
    

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

