//
//  Single+Codable.swift
//  tmbd
//
//  Created by Tarek El Ghoul on 28/10/2023.
//

import RxSwift
import Moya
import Foundation

/// Extension for processing Responses into`Decodable` objects
extension PrimitiveSequence where Trait == SingleTrait, Element == Response {
    
    /// Maps data received from the signal into a an object which implements the `Decodable` protocol
    /// If the conversion fails, the signal errors.
    func mapDecodable<T: Decodable>(_ type: T.Type) -> Single<T> {
        flatMap { Single.just(try $0.mapDecodable(type)) }
    }
    
    func mapDecodable<T: Decodable>(_ type: T.Type, at keyPath: String) -> Single<T> {
        flatMap { Single.just(try $0.mapDecodable(type, at: keyPath)) }
    }
}

private extension Response {
    
    /// Maps response into an object which implements the `Decodable` protocol
    /// If the conversion fails, throws decoding error
    func mapDecodable<T: Decodable>(_ type: T.Type) throws -> T {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
    
    func mapDecodable<T: Decodable>(_ type: T.Type, at keyPath: String) throws -> T {
        guard let array = (try mapJSON() as? NSDictionary)?.value(forKeyPath: keyPath) as? [String: Any],
              let jsonData = try? JSONSerialization.data(withJSONObject: array) else {
            throw MoyaError.jsonMapping(self)
        }
        
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: jsonData)
    }
}

