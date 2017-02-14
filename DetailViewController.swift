//
//  DetailViewController.swift
//  MovieViewer
//
//  Created by my mac on 2/4/17.
//  Copyright © 2017 Eduardo Carrillo. All rights reserved.
//

import UIKit
import AVKit
import MediaPlayer



class DetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var infoView: UIView!
    
    var movie: NSDictionary!
   
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       /*
        var url = URL(string: "https://www.youtube.com/embed/aTNJtEXYsyw")
        var playViewController : AVPlayerViewController = AVPlayerViewController()
        playViewController.view.frame = self.view.bounds
        
        var player : AVPlayer = AVPlayer(url: url!)
        playViewController.player = player
        
        
        self.view.addSubview(playViewController.view)
        player.play()
        */
        
        
        
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width, height: infoView.frame.origin.y + infoView.frame.size.height)
        
        print(movie)
        let title = movie["title"] as? String
        titleLabel.text =  title
        
        let overview = movie["overview"]
        overviewLabel.text = overview as? String
        
        
        
        let baseUrl = "https://image.tmdb.org/t/p/w500"
        
        if let posterPath = movie["poster_path"] as? String{
            let imageUrl = URL(string: baseUrl + posterPath)
            posterView.setImageWith(imageUrl!)
        }
        
        print(movie)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
