//
//  MoviesViewController.swift
//  MovieViewer
//
//  Created by my mac on 2/1/17.
//  Copyright © 2017 Eduardo Carrillo. All rights reserved.
//

import UIKit
import AFNetworking
import SVProgressHUD


class MoviesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate
    
{
   
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var navBar: UINavigationItem!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var errorButton: UIButton!
    
    var movies : [NSDictionary]?
    var endpoint : String!
    var filteredData : [NSDictionary]!
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (endpoint == nil){
            endpoint = "now_playing"
        }
        
        filteredData = movies
        errorButton.isUserInteractionEnabled = true
        
        //Let this controller be in charge of manipulating tableview
        collectionView.dataSource = self;
        collectionView.delegate = self;
        
        searchBar.delegate = self
     
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        
        collectionView.insertSubview(refreshControl, at: 0)
        SVProgressHUD.show()
        SVProgressHUD.setOffsetFromCenter(UIOffsetMake(0.0, 0.0))
        

        refreshControlAction(refreshControl)
        // Do any additional setup after loading the view.    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let filteredData = filteredData {
            return filteredData.count
        }else if let movies = movies {
            return movies.count
        }
        
        return 0;
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath as IndexPath) as! MovieCell
        
        
        let baseUrl = "https://image.tmdb.org/t/p/w500"
        
        let movie = self.filteredData![indexPath.row]
        if let posterPath = movie["poster_path"] as? String{
        let imageUrl = URL(string: baseUrl + posterPath)
            
            let imageRequest = URLRequest(url: imageUrl!)
            cell.posterView.setImageWith(imageRequest, placeholderImage: nil, success: { (request: URLRequest, response:HTTPURLResponse?, image: UIImage) in
                //Image response will be nil if the image is cached.
                if response != nil {
                    print("Image was not cached, so fade in image.")
                    cell.posterView.alpha = 0.0
                    cell.posterView.image = image
                    
                    UIView.animate(withDuration: 0.3, animations: { 
                        cell.posterView.alpha = 1.0
                    })
                }else { //Image came from the cache
                    cell.posterView.image = image
                }
            }, failure: { (request: URLRequest, response: HTTPURLResponse?, error: Error) in
                print("[ERROR] \(error)")
            })
        }
        
        print("collectionView cellForItemAt function called!")
        
        return cell
    }
 
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        filteredData = searchText.isEmpty ? movies : movies?.filter({(data: NSDictionary) -> Bool in
            // If dataItem matches the searchText, return true to include it
            if let text = data["title"] as? String{
                return text.range(of: searchText, options: .caseInsensitive) != nil ;
            }
            return false;
        })
        print("called")
        collectionView.reloadData()
    }
    
    func refreshControlAction(_ refreshControl: UIRefreshControl) {
        
        // ... Create the URLRequest `myRequest` ...
        print("\n\nrefresh control action called!\n\n")
        sendRequest()
        
        
    }
    
   
    @IBAction func onErrorButtonTouch(_ sender: Any) {
        sendRequest()
        
    }
    
    func sendRequest(){
        //Network request set up
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(endpoint!)?api_key=\(apiKey)")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        // Configure session so that completion handler is executed on main UI thread
        let task: URLSessionDataTask = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if let data = data {
                if let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                  
                    self.movies = dataDictionary["results"] as! [NSDictionary]
                    self.filteredData = self.movies
                    //Update the collectionview with its new data
                    self.collectionView.reloadData()
                    self.refreshControl.endRefreshing()
                    print("\n\nData is updated\n\n")
                    SVProgressHUD.dismiss()
                    self.errorButton.isHidden = true
                }
            }else if let error = error{
                self.errorButton.isHidden = false
                self.errorButton.isHighlighted = true
                
                self.backgroundView.bringSubview(toFront: self.errorButton)
                 SVProgressHUD.show()
                self.refreshControl.endRefreshing()
                print("\n\nNetwork error has occurred\n\n")
                
            }
        }
        
        
        task.resume()
    }
    
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let cell = sender as! UICollectionViewCell
        let indexPath = collectionView.indexPath(for: cell)
        let movie = filteredData![indexPath!.row]
        
        let detailViewController = segue.destination as! DetailViewController
        detailViewController.movie = movie
        
        print("prepare for seque called")
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
