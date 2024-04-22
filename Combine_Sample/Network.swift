//
//  Network.swift
//  Combine_Sample
//
//  Created by Perennial on 19/04/24.
//

import Foundation
import Combine

enum NetworkingError: Error {
    case invalidURL
}

class NetworkService {
    func fetchMovies() -> some Publisher<MoviesResponse, Error> {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/upcoming?api_key=\(Constants.API_KEY)") else {
            return Fail(error: NetworkingError.invalidURL).eraseToAnyPublisher()
        }
        
        return URLSession
            .shared
            .dataTaskPublisher(for: url)
            .map(\.data)
        /*.tryMap { data in
         let decoded = try jsonDecoder.decode(MoviesResponse.self, from: data)
         return decoded
         }*/
            .decode(type: MoviesResponse.self, decoder: jsonDecoder)
            .eraseToAnyPublisher()
    }
    
    func searchMovies(for query: String) -> some Publisher<MoviesResponse, Error> {
        let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        guard let url = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=\(Constants.API_KEY)&query=\(encodedQuery!)") else {
            return Fail(error: NetworkingError.invalidURL).eraseToAnyPublisher()
        }
        
        return URLSession
            .shared
            .dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: MoviesResponse.self, decoder: jsonDecoder)
            .eraseToAnyPublisher()
    }
    
    
    func fetchCredits(for movie: Movie) -> some Publisher<MovieCreditsResponse, Error> {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(movie.id)/credits?api_key=\(Constants.API_KEY)") else {
            return Fail(error: NetworkingError.invalidURL).eraseToAnyPublisher()
        }
        
        return URLSession
            .shared
            .dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: MovieCreditsResponse.self, decoder: jsonDecoder)
            .eraseToAnyPublisher()
    }
    
    func fetchReviews(for movie: Movie) -> some Publisher<MovieReviewsResponse, Error> {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(movie.id)/reviews?api_key=\(Constants.API_KEY)") else {
            return Fail(error: NetworkingError.invalidURL).eraseToAnyPublisher()
        }
        
        return URLSession
            .shared
            .dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: MovieReviewsResponse.self, decoder: jsonDecoder)
            .eraseToAnyPublisher()
    }
}
