//
//  MovieProvider.swift
//  tmbd
//
//  Created by Tarek El Ghoul on 28/10/2023.
//

import RxSwift
import Moya

protocol MovieProviderProtocol {
    func getMovies(atPage: Int) -> Single<MovieList>
    func getCastsByMovieId(id: Int) -> Single<CastList>
}

struct MovieProvider: MovieProviderProtocol {
    
    let provider = MoyaProvider<MovieDBAPI>()
    
    func getCastsByMovieId(id: Int) -> Single<CastList> {
        provider.rx.request(.castsByMovieId(id: id))
            .mapDecodable(CastListDto.self)
            .map { CastListMapper.map(dto: $0) }
    }
        
    func getMovies(atPage: Int) -> Single<MovieList> {
        provider.rx.request(.popularMovies(page: atPage))
            .mapDecodable(MovieListDto.self)
            .map { MovieListMapper.map(dto: $0) }
    }
    
}
