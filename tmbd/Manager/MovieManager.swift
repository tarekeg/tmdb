//
//  MovieManager.swift
//  tmbd
//
//  Created by Tarek El Ghoul on 28/10/2023.
//

import RxSwift
import Resolver

protocol MovieManagerProtocol {
    func getMovies(atPage: Int) -> Single<MovieList>
    func getCastsByMovieId(id: Int) -> Single<CastList>
}

struct MovieManager: MovieManagerProtocol {
    
    let movieProvider: MovieProviderProtocol
    
    func getMovies(atPage: Int) -> Single<MovieList> {
        movieProvider.getMovies(atPage: atPage)
    }
    
    func getCastsByMovieId(id: Int) -> Single<CastList> {
        movieProvider.getCastsByMovieId(id: id)
    }
}
