//
//  HTTPClient.swift
//  tmbd
//
//  Created by Tarek El Ghoul on 28/10/2023.
//

import Moya
import RxSwift
import Foundation
import RxMoya

import Moya

enum MovieDBAPI {
    case popularMovies(page: Int)
    case castsByMovieId(id: Int)
}

extension MovieDBAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.themoviedb.org/3")!
    }

    var path: String {
        switch self {
        case .popularMovies:
            return "/movie/popular"
        
        case .castsByMovieId(let movieID):
            return "/movie/\(movieID)/credits"
        }
    }

    var method: Moya.Method {
        return .get
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        switch self {
        case .popularMovies(let page):
            return .requestParameters(parameters: ["language": "en-US", "page": page], encoding: URLEncoding.default)
            
        case .castsByMovieId:
            return .requestParameters(parameters: ["language": "en-US"], encoding: URLEncoding.default)
        }
    }

    var headers: [String: String]? {
        return ["accept": "application/json", "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI2OTRhYTMwYTc4YmQwNmU1NDdhYmZmODc4M2Q4ZjliNCIsInN1YiI6IjY1M2M0OTNjZTg5NGE2MDExY2EyZWZhNiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.BbF2XAY3XwjqarA6xJFOVEBNDBe9NASeefan8jHw0qM"]
    }
}
