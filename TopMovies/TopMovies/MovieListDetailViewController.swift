//
//  MovieListDetailViewController.swift
//  TopMovies
//
//  Created by Suman Chatterjee on 06/04/2017.
//  Copyright © 2017 Suman Chatterjee. All rights reserved.
//

import UIKit

class MovieListDetailViewController: UIViewController {

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var rating: UILabel!
    
    var movieDetail : Movies? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = movieDetail?.title
        self.loadImage(photoURL: (movieDetail?.imageUrl)!)
        self.rating.text = String(format:"%.1f", (movieDetail?.rating)!)
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
        DispatchQueue.global(qos: .userInitiated).async {
            
            guard  let imageData = NSData(contentsOf: url!) else {
                return
            }
            
            DispatchQueue.main.async {
                self.movieImageView?.image = UIImage(data: imageData as Data)
                self.view.setNeedsLayout()
            }
            
        }
}
}

