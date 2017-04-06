//
//  MoviesDownload.swift
//  TopMovies
//
//  Created by Suman Chatterjee on 04/04/2017.
//  Copyright © 2017 Suman Chatterjee. All rights reserved.
//

import Foundation
import SwiftyJSON


import UIKit

protocol MoviesDownloadServiceDelegate {
    func setMovies()
    func errorWithMessage(message: String)
}


class MoviesDownload {
    // Set  appid
    let appid: String
    var delegate: MoviesDownloadServiceDelegate?
    
    /** Initial a MoviesDownload instance with  app id. */
    init(appid: String) {
        self.appid = appid
    }
    
    /** Formats an API call to the Movie DB API */
    func getMovies() {
        
        let path = MovieURL
        
        getTopMoviesWithPath(path: path)
        
    }
    
    /** This Method retrieves  data from an API path. */
    func getTopMoviesWithPath(path: String) {
        // Create a URL, Session, and Data task.
        guard let  url = URL(string: path) else{
            
            print("Error: cannot create URL")
            return
            
        }
        
        
        let config = URLSessionConfiguration.default // Session Configuration
        let session = URLSession(configuration: config) // Load configuration into Session
        
        
        let task = session.dataTask(with: url) {
            (data, response, error) in
            
            var status = 0
            
            // Handle an HTTP status response.
            if let httpResponse = response as? HTTPURLResponse {
                print("*******")
                //print(httpResponse.statusCode)
                status = httpResponse.statusCode
                print("*******")
            }
            
            // Check for nil data
            let json = JSON(data: data!)
            //print(json)
            if json == nil {
                return
            }
            
            
            // Check status
            if status == 200 {
                // everything is ok get the movie data from the json data.
                self.prepareFor(json: json)
                
            } else if status == 404 {
                // Movie not found
                if self.delegate != nil {
                    DispatchQueue.main.async {
                        self.delegate?.errorWithMessage(message: "Data not found")
                    }
                }
                
            } else {
                // Some other here?
                if self.delegate != nil {
                    DispatchQueue.main.async {
                        
                        self.delegate?.errorWithMessage(message: "Something went wrong?")
                    }
                }
                
            }
            
        }
        
        
        // *** This starts the data session ***
        task.resume()
    }
    
    
    func prepareFor (json : JSON)  {
        
        let list = json["results"].arrayObject as! [[String:Any]]
        
        MovieDbBuilder.sharedInstance.buildMovieData(for: list.count, and: json, completionhandler:{ (cancled) in
            
            //print("Download complete")
            
            DispatchQueue.main.async {
                
                self.delegate?.setMovies()
            }
            
        })
    }
    
    
}
