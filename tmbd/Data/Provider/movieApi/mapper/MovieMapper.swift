//
//  MovieMapper.swift
//  tmbd
//
//  Created by Tarek El Ghoul on 28/10/2023.
//

enum MovieMapper {

    static func map(dto: MovieDto) -> Movie? {
        // we can choose what data we need to show a movie here we choose to only have an id and a title other data is optionnal
        guard let id = dto.id, let title = dto.title else {
            return nil
        }
        
        return Movie(id: id,
                     title: title,
                     overview: dto.overview ?? "",
                     voteAverage: dto.voteAverage ?? 0,
                     backDropPath: dto.backDropPath ?? "",
                     posterPath: dto.posterPath ?? "")
        
    }
}
