//
//  CastListMapper.swift
//  tmbd
//
//  Created by Tarek El Ghoul on 28/10/2023.
//

enum CastListMapper {
    
    static func map(dto: CastListDto) -> CastList {
        
        let castDto = dto.cast ?? []
        let cast = castDto.compactMap { CastMapper.map(dto: $0) }
        
        return CastList(cast: cast)
        
    }
    
}
