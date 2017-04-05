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

    var moviesDownload :MoviesDownload = MoviesDownload(appid: "53206ffa8c92b79f75b3ab4d7bd9f245")

    override func viewDidLoad() {
        
        super.viewDidLoad()
        moviesDownload.delegate = self
        moviesDownload.getMovies()
        
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
        
        return cell
    }
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MovieListTableViewController {
    
    func setMovies() {
        
        DispatchQueue.main.async {
            
        self.activityIndecator.stopAnimating()
        self.movieLists  = MovieDbBuilder.sharedInstance.movieList
        self.tableView.reloadData()
        }
        
    }
    
    func errorWithMessage(message: String) {
        
        
    }

    
    

}
