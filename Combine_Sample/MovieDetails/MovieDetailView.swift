//
//  MovieDetailView.swift
//  Combine_Sample
//
//  Created by Perennial on 19/04/24.
//

import SwiftUI
import Combine

struct MovieDetailView: View {
    @StateObject var viewModel: MovieDetailViewModel
    
    init(movie: Movie) {
        _viewModel = StateObject(wrappedValue: MovieDetailViewModel(movie: movie, service: NetworkService()))
    }
    
    var body: some View {
        List {
            Section {
                ForEach(viewModel.data.credits) { credit in
                    HStack(spacing: 5) {
                        AsyncImage(url: credit.profileURL) { poster in
                            poster
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 80, height: 80)
                        } placeholder: {
                            ProgressView()
                                .frame(width: 80, height: 80)
                        }
                        
                        VStack(alignment: .leading) {
                            Text(credit.name)
                                .font(.headline)
                            Text(credit.character)
                                .font(.caption)
                        }
                    }
                }
            } header: {
                Text("Cast")
            }
            
            Section {
                ForEach(viewModel.data.reviews) { review in
                    VStack(alignment: .leading) {
                        Text(review.author)
                            .font(.headline)
                        Text(review.content)
                            .font(.body)
                    }
                }
            } header: {
                Text("Reviews")
            }

        }
        .navigationTitle(viewModel.movie.title)
        .onAppear {
            viewModel.fetchData()
        }
    }
}

#Preview {
    MovieDetailView(movie: Movie(id: 580489,
                                 title: "Venom: Let There Be Carnage",
                                 overview: "After finding a host body in investigative reporter Eddie Brock, the alien symbiote must face a new enemy, Carnage, the alter ego of serial killer Cletus Kasady.",
                                 posterPath: "/rjkmN1dniUHVYAtwuV3Tji7FsDO.jpg"))
}
