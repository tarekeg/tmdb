//
//  MovieListMapper.swift
//  tmbd
//
//  Created by Tarek El Ghoul on 28/10/2023.
//

enum MovieListMapper {
    
    static func map(dto: MovieListDto) -> MovieList {
        
        let moviesDto = dto.movies ?? []
        let movies = moviesDto.compactMap { MovieMapper.map(dto: $0) }
        
        return MovieList(movies: movies, page: dto.page ?? 1, totalPages: dto.totalPages ?? 1)
        
    }
    
}
