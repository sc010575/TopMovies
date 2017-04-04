//
//  MovieDbBuilder.swift
//  TopMovies
//
//  Created by Suman Chatterjee on 04/04/2017.
//  Copyright © 2017 Suman Chatterjee. All rights reserved.
//

import Foundation


class MovieDbBuilder {
    
    
    public typealias completionHandler = ( _ cancelled: Bool) -> Void
    
    
    var movieList : [Movies] = []
    
    
    // MARK: - Initialization methods
    
    static let sharedInstance = MovieDbBuilder()

}


extension  MovieDbBuilder{
    
    func buildMovieData(for movies: Int , and records: JSON , completionhandler:@escaping completionHandler )  {
        
        movieList.removeAll()
        
        for i in 0...movies - 1 {
            
            
            let title        = records["results"][i]["title"].stringValue
            let overview     = records["results"][i]["overview"].stringValue
            let imageUrl     = records["results"][i]["poster_path"].stringValue
            let rating       = records["results"][i]["vote_average"].doubleValue
            
           
            // Create a Movie struct to pass to the delegate.
            let movie = Movies(title: title, overview: overview, imageUrl: imageUrl, rating: rating)
            
            self.movieList.append(movie)
        }
        completionhandler(true)
    }
    
}
