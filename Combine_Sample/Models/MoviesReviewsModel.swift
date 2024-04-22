//
//  MoviesReviewsModel.swift
//  Combine_Sample
//
//  Created by Perennial on 22/04/24.
//

import Foundation

struct MovieReviewsResponse: Codable {
    let results: [MovieReview]
}


struct MovieReview: Identifiable, Equatable, Codable {
    let id: String
    let author: String
    let content: String
}
