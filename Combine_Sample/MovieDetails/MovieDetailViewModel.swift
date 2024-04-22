//
//  MovieDetailViewModel.swift
//  Combine_Sample
//
//  Created by Perennial on 19/04/24.
//

import Foundation
import Combine

class MovieDetailViewModel: ObservableObject {
    let movie: Movie
    private let service: NetworkService
    
    @Published var data: (credits: [MovieCast], reviews: [MovieReview]) = ([], [])
    
    init(movie: Movie, service: NetworkService) {
        self.movie = movie
        self.service = service
    }
    
    func fetchData() {
        let creditsPublisher = service.fetchCredits(for: movie).map(\.cast).replaceError(with: [])
        let reviewsPublisher = service.fetchReviews(for: movie).map(\.results).replaceError(with: [])
        
        Publishers.Zip(creditsPublisher, reviewsPublisher)
            .receive(on: DispatchQueue.main)
            .map { (credits: $0.0, reviews: $0.1) }
            .assign(to: &$data)
    }
    
}
