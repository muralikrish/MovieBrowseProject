//
//  MovieCell.swift
//  MovieDB
//
//  Created by Teja Bethina on 6/1/21.
//

import UIKit

class MovieCell: UITableViewCell {
    @IBOutlet weak var movieTitleLabel: UILabel?
    @IBOutlet weak var movieReleaseDateLabel: UILabel?
    @IBOutlet weak var movieRattingLabel: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        accessoryType = .disclosureIndicator
    }
    
    func configureData(movie: Movie) {
        movieTitleLabel?.text = movie.original_title
        movieReleaseDateLabel?.text = movie.release_date
        movieRattingLabel?.text = "\(movie.vote_average)"
    }
}
