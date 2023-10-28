//
//  MovieCastsViewModel.swift
//  tmbd
//
//  Created by Tarek El Ghoul on 28/10/2023.
//

import Resolver

class MovieCastsViewModel: Subscribable {
    
    @Injected private var movieManager: MovieManagerProtocol
    @Mutable.LateInit private(set) var movie: Movie
    @Mutable private(set) var castList: CastList = CastList(cast: [])
    
    func initialize(movie: Movie) {
        self.movie = movie
    }
    
    func onViewDidload() {
        getCast()
    }
    
    func getCast() {
        sub(movieManager.getCastsByMovieId(id: movie.id).subscribe(
            onSuccess: { [weak self] castList in
                self?.castList = castList
            },
            onFailure: { error in
                print("error:", error)
            }))
    }
    
}
