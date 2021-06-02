//
//  MovieDetailsVC.swift
//  MovieDB
//
//  Created by Teja Bethina on 6/1/21.
//

import UIKit

class MovieDetailsVC: UIViewController {
    
    @IBOutlet var movieTitleLabel: UILabel!
    @IBOutlet var movieReleaseDateLabel: UILabel!
    @IBOutlet var movieDetailsTextView: UITextView!
    @IBOutlet var moviePosterImageView: UIImageView!
    var movieDetails: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fillMovieDetails()
    }
    
    func fillMovieDetails() {
        if let details = movieDetails {
            movieTitleLabel.text = details.original_title
            movieReleaseDateLabel.text = "Release Date: " + details.release_date
            movieDetailsTextView.text = details.overview
            
            moviePosterImageView.image = UIImage(named: "placeholder")
            let url = "https://image.tmdb.org/t/p/w500/" + details.poster_path
            Network().execute(urlString: url) { (imageData) in
                DispatchQueue.main.async {
                  self.moviePosterImageView.image = UIImage(data: imageData)
                }
            } errorHandler: { (errorStr) in
            }

        }
    }
    
}
