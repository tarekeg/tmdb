//
//  MovieDto.swift
//  tmbd
//
//  Created by Tarek El Ghoul on 28/10/2023.
//

struct MovieDto: Decodable {
    let id: Int?
    let title: String?
    let overview: String?
    let voteAverage: Float?
    let backDropPath: String?
    let posterPath: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title = "original_title"
        case overview
        case voteAverage = "vote_average"
        case backDropPath = "backdrop_path"
        case posterPath = "poster_path"
    }
}
