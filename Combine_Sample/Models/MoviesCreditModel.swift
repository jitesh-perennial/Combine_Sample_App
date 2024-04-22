//
//  MoviesCreditModel.swift
//  Combine_Sample
//
//  Created by Perennial on 22/04/24.
//

import Foundation

struct MovieCreditsResponse: Codable {
    let cast: [MovieCast]
}

struct MovieCast: Codable, Identifiable, Equatable {
    let id: Int
    let name: String
    let character: String
    let profilePath: String?
    var profileURL: URL? {
        profilePath.map { URL(string: "https://image.tmdb.org/t/p/w400/\($0)")! }
    }
}
