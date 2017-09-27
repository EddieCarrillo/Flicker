//
//  DetailMovieView.swift
//  MovieViewer
//
//  Created by my mac on 9/27/17.
//  Copyright © 2017 Eduardo Carrillo. All rights reserved.
//

import UIKit

class DetailMovieView: UIView {
    
    
    
    
    
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var infoView: UIView!
    

    var movie: Movie? {
        
        
        didSet{
            if let movie = self.movie {
                let title = movie.title
                titleLabel.text =  title
                
                let overview = movie.overview
                overviewLabel.text = overview
                let baseUrl = NetworkAPI.sharedInstance.standardWidthImageBaseUrl
                
                if let posterPath = movie.posterPath{
                    let imageUrl = URL(string: baseUrl + posterPath)
                    posterView.setImageWith(imageUrl!)
                }
            }
        }
        
    }

}
