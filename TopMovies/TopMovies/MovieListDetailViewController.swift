//
//  MovieListDetailViewController.swift
//  TopMovies
//
//  Created by Suman Chatterjee on 06/04/2017.
//  Copyright © 2017 Suman Chatterjee. All rights reserved.
//

import UIKit
import Kingfisher

class MovieListDetailViewController: UIViewController {

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var rating: UILabel!
    
    var movieDetail : Movies? = nil
    @IBOutlet weak var overview: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = movieDetail?.title

        self.rating.text = String(format:"%.1f", (movieDetail?.rating)!)
        self.overview.text = movieDetail?.overview
        
        //load imageview
        let imageURL  = ImageURL + (movieDetail?.imageUrl)!
        guard let url = URL(string: imageURL) , let imageView = self.movieImageView , let key = movieDetail?.title else {
            
            self.movieImageView.image = nil
            return
        }
        MoviesDownload.loadImage(for: url, cacheKey: key, inView: imageView)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

extension MovieListDetailViewController {
    
    
    func loadImage(photoURL: String) {
        
        let imageURL  = ImageURL + photoURL
        let url = URL(string: imageURL)
        
        self.movieImageView.kf.setImage(with: url)
        
        
 /*       DispatchQueue.global(qos: .userInitiated).async {
            
            guard  let imageData = NSData(contentsOf: url!) else {
                return
            }
            
            DispatchQueue.main.async {
                self.movieImageView?.image = UIImage(data: imageData as Data)
                self.view.setNeedsLayout()
            }
 
        }
 */
}
}

