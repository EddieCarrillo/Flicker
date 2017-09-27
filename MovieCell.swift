//
//  MovieCell.swift
//  MovieViewer
//
//  Created by my mac on 2/4/17.
//  Copyright © 2017 Eduardo Carrillo. All rights reserved.
//

import UIKit

class MovieCell: UICollectionViewCell {
    
    static let reuseId = "MovieCell"
    
    @IBOutlet weak var posterView: UIImageView!
    
    var movie: Movie? {
        didSet {
            guard let movie = self.movie, let posterPath = movie.posterPath else {
                return;
            }
            let urlImageStr = NetworkAPI.sharedInstance.standardWidthImageBaseUrl
            posterView.setImageWith(URL(string: "\(urlImageStr)/\(posterPath)")!)
        }
    
    }
    
    
}
