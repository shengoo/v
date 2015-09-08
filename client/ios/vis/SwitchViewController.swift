//
//  SwitchViewController.swift
//  vis
//
//  Created by Qing Sheng on 15/9/8.
//  Copyright (c) 2015年 Sheng Qing. All rights reserved.
//

import UIKit

class SwitchViewController: UIViewController {

    @IBOutlet weak var WifiOpen: UIButton!
    @IBOutlet weak var WifiClose: UIButton!
    
    
    @IBOutlet weak var autoOpen: UIButton!
    @IBOutlet weak var autoClose: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        WifiOpen.setTitleColor(UIColor.blackColor(), forState: .Selected)
        WifiOpen.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
        WifiClose.setTitleColor(UIColor.blackColor(), forState: .Selected)
        WifiClose.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
        
        autoOpen.setTitleColor(UIColor.blackColor(), forState: .Selected)
        autoOpen.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
        autoClose.setTitleColor(UIColor.blackColor(), forState: .Selected)
        autoClose.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
        
        WifiOpen.selected = !WifiOpen.selected
        autoOpen.selected = !autoOpen.selected
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func WifiOpenClick(sender: UIButton) {
        if(WifiOpen.selected){
            return
        }
        WifiOpen.selected = !WifiOpen.selected
        WifiClose.selected = !WifiClose.selected
    }
    
    @IBAction func WifiCloseClick(sender: UIButton) {
        if(WifiClose.selected){
            return
        }
        WifiClose.selected = !WifiClose.selected
        WifiOpen.selected = !WifiOpen.selected
    }
    
    
    @IBAction func AutoOpenClick(sender: UIButton) {
        if(autoOpen.selected){
            return
        }
        autoOpen.selected = !autoOpen.selected
        autoClose.selected = !autoClose.selected
    }
    
    @IBAction func AutoCloseClick(sender: UIButton) {
        if(autoClose.selected){
            return
        }
        autoClose.selected = !autoClose.selected
        autoOpen.selected = !autoOpen.selected
    }
    
    
    
    @IBAction func ClearAllCache(sender: UIButton) {
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
