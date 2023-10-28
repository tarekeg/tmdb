//
//  CastMapper.swift
//  tmbd
//
//  Created by Tarek El Ghoul on 28/10/2023.
//

enum CastMapper {

    static func map(dto: CastDto) -> Cast? {
        guard let name = dto.name, let profilePath = dto.profilePath else {
            return nil
        }
        
        return Cast(name: name, profilePath: profilePath)
        
    }
}
