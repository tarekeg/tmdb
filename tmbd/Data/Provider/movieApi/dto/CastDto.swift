//
//  CastDto.swift
//  tmbd
//
//  Created by Tarek El Ghoul on 28/10/2023.
//

struct CastDto: Decodable {
    let name: String?
    let profilePath: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case profilePath = "profile_path"
    }

    
}

