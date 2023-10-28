//
//  MovieListDto.swift
//  tmbd
//
//  Created by Tarek El Ghoul on 28/10/2023.
//

struct MovieListDto: Decodable {
    let movies: [MovieDto]?
    let page: Int?
    let totalPages: Int?
    
    enum CodingKeys: String, CodingKey {
        case movies = "results"
        case page
        case totalPages = "total_pages"
    }
}
