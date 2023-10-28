//
//  MovieCastsViewController.swift
//  tmbd
//
//  Created by Tarek El Ghoul on 28/10/2023.
//

import UIKit
import Resolver
import Kingfisher

class MovieCastsViewController: UIViewController, Subscribable {
    
    // MARK: - IBOutles
    
    @IBOutlet private weak var movieTitleLabel: UILabel!
    @IBOutlet private weak var movieImageView: UIImageView!
    @IBOutlet private weak var movieSynopsisLabel: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    // MARK: - Private properties
    
    private lazy var viewModel: MovieCastsViewModel = MovieCastsViewModel()
    private var movie: Movie?
    private var casts: [Cast] = []
    private let castCellIdentifier = "CastCell"
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.onViewDidload()
        observeViewData()
        setupCollectionView()
        setupUI()
    }
    
    // MARK: - Public functions
    
    func initialize(with movie: Movie) {
        viewModel.initialize(movie: movie)
        self.movie = movie
    }
    
    // MARK: - Private functions
    
    private func setupCollectionView() {
        let nib = UINib(nibName: castCellIdentifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: castCellIdentifier)
    }
    
    private func setupUI() {
        extendedLayoutIncludesOpaqueBars = true
        guard let movie = movie else {
            return
        }
        
        downloadImage(imageStringUrl: movie.backDropPath)
        movieTitleLabel.text = movie.title
        movieSynopsisLabel.text = movie.overview
    }
    
    private func observeViewData() {
        sub(viewModel.$castList.subscribe(onNext: { [weak self] castList in
            if !castList.cast.isEmpty {
                self?.casts = castList.cast
                self?.collectionView.reloadData()
            }
        }))
    }
    
    private func downloadImage(imageStringUrl: String) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500" + imageStringUrl) else {
            return
        }
        
        movieImageView.kf.setImage(with: url)
    }
}

// MARK: - UICollectionViewDataSource

extension MovieCastsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (casts.count > 5) ? 5 : casts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: castCellIdentifier, for: indexPath) as! CastCell
        cell.configure(cast: casts[indexPath.item])
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MovieCastsViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 128, height: 144)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        10
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        8
    }
}


