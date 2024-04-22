//
//  ContentView.swift
//  Combine_Sample
//
//  Created by Perennial on 19/04/24.
//

import SwiftUI

struct MoviesView: View {
    @StateObject var viewModel: MoviesViewModel
    
    init() {
        _viewModel = StateObject(wrappedValue: MoviesViewModel(service: NetworkService()))
    }
    
    var body: some View {
        List(viewModel.movies) { movie in
            
            NavigationLink {
                MovieDetailView(movie: movie)
            } label: {
                HStack(spacing: 5) {
                    AsyncImage(url: movie.posterURL) { poster in
                        poster
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100)
                    } placeholder: {
                        ProgressView()
                            .frame(width: 100)
                    }
                    VStack(alignment: .leading) {
                        Text(movie.title)
                            .font(.headline)
                        Text(movie.overview)
                            .font(.caption)
                            .lineLimit(3)
                    }
                }
            }
        }
        .navigationTitle("Upcoming movies")
        .searchable(text: $viewModel.searchQuery)
        .onAppear {
            viewModel.fetchMovieList()
        }
    }
}

#Preview {
    MoviesView()
}
