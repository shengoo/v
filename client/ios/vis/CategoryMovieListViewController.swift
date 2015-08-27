//
//  CategoryMovieListViewController.swift
//  vis
//
//  Created by Qing Sheng on 15/8/5.
//  Copyright (c) 2015年 Sheng Qing. All rights reserved.
//

import UIKit

class CategoryMovieListViewController: UIViewController ,UITableViewDelegate, UITableViewDataSource {
    
    
    var category:Category?
    
    @IBOutlet weak var tableView: UITableView!
    
    var movies = [Movie]()
    
    var service:MovieService!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = category?.name
        
        var nib = UINib(nibName: "MovieTableViewCell", bundle: nil)
        
        tableView.registerNib(nib, forCellReuseIdentifier: "cell")
        
        
        
        service = MovieService()
        service.getByCategory(category!.name, callback: {
            (response) in
            self.loadMovies(response)
        })
    }
    
    func loadMovies(movies:NSArray){
        for movie in movies {
            var id = movie["id"] as! Int
            var title = movie["title"] as! String
            var description = movie["description"] as! String
            var date = movie["date"] as! String
            var category = movie["category"] as! String
            var length = movie["length"] as! Int
            var image = movie["image"] as! String
            var video = movie["video"] as! String
            var dataItem = Movie(id: id, title: title, desc: description, date: date, category: category, length: length, image: image, video: video)
            self.movies.append(dataItem)
        }
        dispatch_async(dispatch_get_main_queue(), {
            self.tableView.reloadData()
        })
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        var cell:MovieTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell") as! MovieTableViewCell
        
        var movie = movies[indexPath.row]
        
        cell.loadItem(movie.title, image: movie.image,category: movie.category)
        
        return cell
        
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier(movieSegueIdentifier, sender: tableView)
    }
    
    
    let movieSegueIdentifier = "ShowMovieSegue"
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        println(segue.identifier)
        if segue.identifier == movieSegueIdentifier {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let movie = movies[indexPath.row]
                (segue.destinationViewController as! MovieViewController).movie = movie
            }
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
