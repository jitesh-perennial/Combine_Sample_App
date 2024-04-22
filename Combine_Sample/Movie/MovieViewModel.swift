//
//  MovieViewModel.swift
//  Combine_Sample
//
//  Created by Perennial on 19/04/24.
//

import Foundation
import Combine

final class MoviesViewModel: ObservableObject {
    @Published private var upcomingMovies: [Movie] = []
    
    @Published var searchQuery = ""
    @Published private var searchResults: [Movie] = []
    
    private let service: NetworkService
    
    var movies: [Movie] {
        if searchQuery.isEmpty {
            return upcomingMovies
        } else {
            return searchResults
        }
    }
    
    init(service: NetworkService) {
        self.service = service
        
        $searchQuery
            .debounce(for: 1.0, scheduler: DispatchQueue.main)
            .map { searchQuery in
                service.searchMovies(for: searchQuery)
                    .replaceError(with: MoviesResponse(results: []))
            }
            .switchToLatest()
            .map(\.results)
            .receive(on: DispatchQueue.main)
            .assign(to: &$searchResults)
    }
    
    func fetchMovieList() {
        service.fetchMovies()
            .map(\.results)
            .receive(on: DispatchQueue.main)
            .replaceError(with: [])
            .assign(to: &$upcomingMovies)
            
            
            /*.sink { completion in
                switch completion {
                case .finished: ()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] movies in
                guard let self = self else { return }
                self.movies = movies
            }
            .store(in: &cancellables)*/

    }
}
