//
//  MoviesModel.swift
//  Combine_Sample
//
//  Created by Perennial on 22/04/24.
//

import Foundation

let jsonDecoder: JSONDecoder = {
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    return decoder
}()


struct MoviesResponse: Codable {
    let results: [Movie]
}

struct Movie: Codable, Identifiable, Equatable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    var posterURL: URL? {
        posterPath.map { URL(string: "https://image.tmdb.org/t/p/w400/\($0)")! }
    }
}
