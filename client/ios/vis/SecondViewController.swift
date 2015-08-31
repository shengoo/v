//
//  SecondViewController.swift
//  vis
//
//  Created by Qing Sheng on 15/7/20.
//  Copyright (c) 2015年 Sheng Qing. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var categories = [Category]()
    
    var service:MovieService!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationItem.title = "返回"
        navigationItem.titleView = UIView()
        
        
        let leftButton = UIBarButtonItem(image: UIImage(named: "navleft"), style: UIBarButtonItemStyle.Plain, target: self, action: "doNothing")
        //        leftButton.enabled = false
        self.navigationItem.leftBarButtonItem = leftButton
        
        
        let rightButton = UIBarButtonItem(image: UIImage(named: "setting"), style: UIBarButtonItemStyle.Plain, target: self, action: "navRightClicked")
        self.navigationItem.rightBarButtonItem = rightButton
        
        
        
        var flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSizeMake((UIScreen.mainScreen().bounds.width / 2) - 1, (UIScreen.mainScreen().bounds.width / 2) - 1)
        flowLayout.minimumLineSpacing = 2
        flowLayout.minimumInteritemSpacing = 2
        self.collectionView.collectionViewLayout = flowLayout
        
        var nib = UINib(nibName: "CategoryCollectionViewCell", bundle: nil)
        
        collectionView.registerNib(nib, forCellWithReuseIdentifier: "cell")
        
        
        service = MovieService()
        service.getCategory({
            (response) in
            self.loadCategories(response)
        })
        
    }
    
    override func viewWillAppear(animated: Bool){
        self.tabBarController?.tabBar.hidden = false
    }
    
    func doNothing(){
        println("do nothing")
    }
    
    func navRightClicked(){
        performSegueWithIdentifier("showSetting", sender: nil)
    }
    
    func loadCategories(data:NSArray){
        for item in data {
            var name = item["title"] as! String
            var image = item["image"] as! String
            var category = Category(name: name, image: image)
            self.categories.append(category)
        }
        dispatch_async(dispatch_get_main_queue(), {
            self.collectionView.reloadData()
        })
    }

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return categories.count;
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        
        var cell = self.collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CategoryCollectionViewCell
        
        var category = categories[indexPath.row]
        
        var str = "http://182.92.153.230/file/" + category.image
        var url = NSURL(string: str.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!)
        cell.image.sd_setImageWithURL(url)
        cell.label.text = category.name

        return cell;
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath){
        performSegueWithIdentifier(showListSegueIdentifier, sender: indexPath)
    }
    
    let showListSegueIdentifier = "showList"
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == showListSegueIdentifier {
            if let indexPath = sender as? NSIndexPath {
                let category = categories[indexPath.row]
                (segue.destinationViewController as! CategoryMovieListViewController).category = category
            }
        }
    }

    



}

