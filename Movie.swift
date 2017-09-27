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
    var overview: String?
    var originalTitle: String?
    var popularity: Int?
    var releaseDate: String?
    var title: String?
    var voteAverage: Int?
    var voteCount: Int?
    var originalLanguage: String?
    var genreIds: [Int]?
    var backdropPath: String?
    
    
    init(jsonMap: NSDictionary){
        
       // print("\n\n\n\n\n____jsonMap____\n\(jsonMap)\n____\n\n\n\n\n")
//        print ("average: \(jsonMap["vote_average"])")
        
        if let path = jsonMap["poster_path"] as? String {
            self.posterPath = path;
        }else {
            print("Could not extract post path from JSON")
        }
        if let backdrop = jsonMap["backdrop_path"] as? String {
            self.backdropPath = backdrop
        }else {
             print("Could not extract backdrop path from JSON")
        }
        if let genreIds = jsonMap["genre_ids"] as? [Int] {
            self.genreIds = genreIds
        }else {
            print("Could not extract genre ids  from JSON")
        }
        if let originalLang = jsonMap["original_language"] as? String {
            self.originalLanguage = originalLang
        }else {
            print("Could not extract original language  from JSON")
        }
        if let originalTitle = jsonMap["original_title"] as? String {
            self.originalTitle = originalTitle
        }else {
            print("Could not extract original title from JSON")
        }
        if let overview = jsonMap["overview"] as? String {
            self.overview = overview
        }else {
            print("Could not extract overview from JSON")
        }
        if let popularity = jsonMap["popularity"] as? Int {
            self.popularity = popularity
        }else {
            print("Could not extract popularity from JSON")
        }
        if let releaseDate = jsonMap["release_date"] as? String {
            self.releaseDate = releaseDate
        }else {
            print("Could not extract release date")
        }
        if let voteAverage = jsonMap["vote_average"] as? Int {
            self.voteAverage = voteAverage
        }else {
            print("Could not extract vote average.")
        }
        if let voteCount = jsonMap["vote_count"] as? Int  {
             self.voteCount = voteCount
        }else {
            print("Could not extact the vote count.")
        }
        if let title = jsonMap["title"] as? String {
            self.title = title
        }else {
           print("Could not extact the title.")
        }
    }

    
    
}
