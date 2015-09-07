//
//  HuancunViewController.swift
//  vis
//
//  Created by 生庆 on 15/9/7.
//  Copyright (c) 2015年 Sheng Qing. All rights reserved.
//

import UIKit

class HuancunViewController: UIViewController ,UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var table: UITableView!
    var movies = [Movie]()
    var service = MovieService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var nib = UINib(nibName: "MovieTableViewCell", bundle: nil)
        table.registerNib(nib, forCellReuseIdentifier: "cell")
        
        movies = service.getHuancun()
        table.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        var cell:MovieTableViewCell = self.table.dequeueReusableCellWithIdentifier("cell") as! MovieTableViewCell
        
        var movie = movies[indexPath.row]
        
        cell.loadItem(movie.title, image: movie.image,category: movie.category)
        
        return cell
        
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier(movieSegueIdentifier, sender: tableView)
    }
    
    
    let movieSegueIdentifier = "ShowMovieSegue"
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == movieSegueIdentifier {
            if let indexPath = self.table.indexPathForSelectedRow() {
                let movie = movies[indexPath.row]
                (segue.destinationViewController as! MovieViewController).movie = movie
            }
        }
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
