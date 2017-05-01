//
//  MovieListTableViewController.swift
//  TopMovies
//
//  Created by Suman Chatterjee on 04/04/2017.
//  Copyright © 2017 Suman Chatterjee. All rights reserved.
//

import UIKit

class MovieListTableViewController: UITableViewController , MoviesDownloadServiceDelegate {
    
    @IBOutlet weak var activityIndecator: UIActivityIndicatorView!
    
    var movieLists : [Movies] = []

    var moviesDownload :MoviesDownload = MoviesDownload(appid: ApiKey)

    override func viewDidLoad() {
        
        super.viewDidLoad()
        moviesDownload.delegate = self
        
        if currentReachabilityStatus == .notReachable {
            
            self.errorWithMessage(message: "No Network Connection")
            return
        }
        

        moviesDownload.getMovies()
        self.title = "Top twenty Movies in UK."
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return movieLists.count
    
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let movieInfo : Movies = movieLists[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MoviesTableViewCell.self), for: indexPath)
        
        guard let tableViewCell = cell as? MoviesTableViewCell else {
            return cell
        }
        
        tableViewCell.title.text = movieInfo.title
        tableViewCell.overview.text = movieInfo.overview
        self.loadImage(cell: tableViewCell, photoURL: movieInfo.imageUrl , cacheKey: movieInfo.title)
        return cell
    }
    
    


}

// MARK: - Image Loading

extension MovieListTableViewController {
    
    func loadImage(cell: MoviesTableViewCell, photoURL: String ,cacheKey: String ) {
        
        let imageURL  = ImageURL + photoURL
        guard let url = URL(string: imageURL) , let imageView = cell.imageView else {
         
            return
        }
        
        MoviesDownload.loadImage(for: url, cacheKey: cacheKey, inView: imageView)
        
  /*      cell.movieImageIndecator.startAnimating()
        let imageURL  = ImageURL + photoURL
        let url = URL(string: imageURL)
        DispatchQueue.global(qos: .userInitiated).async {
        
            guard  let imageData = NSData(contentsOf: url!) else {
                return
            }
            
             DispatchQueue.main.async {
                cell.movieImageIndecator.stopAnimating()
                cell.imageView?.image = UIImage(data: imageData as Data)
                cell.setNeedsLayout()
            }
            
        }*/
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MovieDetails" {
            let nextScene =  segue.destination as! MovieListDetailViewController
            
            // Pass the selected object to the new view controller.
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let movieDetail = movieLists[indexPath.row]
                nextScene.movieDetail = movieDetail
            }
        }
    }
    

}


// MARK: - MoviesDownloadServiceDelegate functions 

extension MovieListTableViewController {
    
    func setMovies() {
        
        DispatchQueue.main.async {
            
        self.activityIndecator.stopAnimating()
        self.movieLists  = MovieDbBuilder.sharedInstance.movieList
        self.tableView.reloadData()
        }
        
    }
    
    func errorWithMessage(message: String) {
        
        let alert = UIAlertController(title: "Movie DB Service Error", message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
       
    }

}
