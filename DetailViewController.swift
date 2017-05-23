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
import SVProgressHUD
import Alamofire
import JASON




class DetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate,
UIWebViewDelegate{

    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var infoView: UIView!
   
    @IBOutlet weak var videoView: UIWebView!
    
    var movie: NSDictionary!
   
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
      videoView.isHidden = true
        
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width, height: infoView.frame.origin.y + infoView.frame.size.height)
        
        let title = movie["title"] as! String
        titleLabel.text =  title
        
        let overview = movie["overview"]
        overviewLabel.text = overview as! String
        let baseUrl = "https://image.tmdb.org/t/p/w500"

        
        if let posterPath = movie["poster_path"] as? String{
            let imageUrl = URL(string: baseUrl + posterPath)
            posterView.setImageWith(imageUrl!)
        }
        
        
        let movieId = movie["id"] as! Int
        print(movieId)
       
    
        
        
            print("movieID: \(movieId)")
        let idString : String = String(movieId)
            //Network request set up
            let urlString =  "https://api.themoviedb.org/3/movie/\(idString)/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US"
        
        
        
        Alamofire.request(urlString).responseJSON { response in
            debugPrint(response)
            
            if let json : String? = response.result.value as? String{
                let jsonResponse : JSON? = JSON(json)
                let layer1  = (jsonResponse?[1])
                print("layer")
                print(layer1)
              
                print("\n\n\njson reponse: \(jsonResponse!)\n\n\n")
                
            }
        }
        
       /*
        if  let results = jsonResponse?[1] as? [NSDictionary]{
                if let videoObject = results[0] as? NSDictionary{
                print("videoObject")
                print(videoObject)
                
                let youtubeKey = videoObject["key"] as? String
                print("youtube key: \(youtubeKey)")
                
                
                let youtubeString = "https://www.youtube.com/embed/\(youtubeKey)"
                
                var youtubeUrl = URL(string: youtubeString)!
                
                let width = videoView.bounds.width
                let height = videoView.bounds.height
                
                
                videoView.loadHTMLString("<iframe width=\"\(width)\" height=\"\(height)\" src=\"\(youtubeString)\" frameborder=\"0\" allowfullscreen></iframe>", baseURL: youtubeUrl)
                videoView.isHidden = true
                while (videoView.isLoading){
                    print("Loading....")
                }
                
                videoView.isHidden = false
                
            }
            
        }
        */
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func sendRequest(){
        
        
        
    }
    
    public func webViewDidStartLoad(_ webView: UIWebView){
        print("Started video...")
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
