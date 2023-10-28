//
//  MovieCell.swift
//  tmbd
//
//  Created by Tarek El Ghoul on 28/10/2023.
//

import UIKit
import Kingfisher
import Alamofire

class MovieCell: UITableViewCell {
    
    // MARK: - IBOutlets

    @IBOutlet private weak var movieImageView: UIImageView!
    @IBOutlet private weak var movieTitleLabel: UILabel!
    @IBOutlet private weak var movieAverageLabel: UILabel!
    
    // MARK: - Public functions
    
    func configure(with movie: Movie) {
        movieTitleLabel.text = movie.title
        movieAverageLabel.text = String(format: "%.1f", movie.voteAverage)
        downloadImage(imageStringUrl: movie.posterPath)
    }
    
    // MARK: - Private functions
    
    private func downloadImage(imageStringUrl: String) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500" + imageStringUrl) else {
            return
        }
        
        movieImageView.kf.setImage(with: url)
    }
    
}
