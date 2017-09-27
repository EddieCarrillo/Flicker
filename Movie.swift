//
//  Movie.swift
//  MovieViewer
//
//  Created by my mac on 9/26/17.
//  Copyright © 2017 Eduardo Carrillo. All rights reserved.
//

import Foundation

class Movie {
    
    
    
    var posterPath: String?
    
    init(jsonMap: NSDictionary){
        if let path = jsonMap["poster_path"] as? String {
            self.posterPath = path;
        }else {
            print("Could not extract post path from JSON")
        }
    }

    
    
}
