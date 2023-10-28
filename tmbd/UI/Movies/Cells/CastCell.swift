//
//  CastCell.swift
//  tmbd
//
//  Created by Tarek El Ghoul on 28/10/2023.
//

import UIKit
import Kingfisher

class CastCell: UICollectionViewCell {
    
    // MARK: - IBOutlets

    @IBOutlet private weak var castImageView: UIImageView!
    @IBOutlet weak var castNameLabel: UILabel!
    
    // MARK: - Public functions
    
    func configure(cast: Cast) {
        castNameLabel.text = cast.name
        downloadImage(imageStringUrl: cast.profilePath)
    }
    
    // MARK: - Private functions
    
    private func downloadImage(imageStringUrl: String) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500" + imageStringUrl) else {
            return
        }
        
        castImageView.kf.setImage(with: url)
    }

}
