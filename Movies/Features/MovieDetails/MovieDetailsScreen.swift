//
//  MovieDetailsScreen.swift
//  Movies
//
//  Created by Foundation on 2022. 02. 14..
//

import Foundation
import SwiftUI

protocol MovieDetailsScreenViewModelProtocol: ObservableObject {
    var movie: MovieVM { get }
}

struct MovieDetailsScreen<ViewModel: MovieDetailsScreenViewModelProtocol>: View {
    let viewModel: ViewModel

    var body: some View {
        ScrollView {
            Color.clear
                .aspectRatio(0.7, contentMode: .fill)
                .overlay(AsyncImage(url: viewModel.movie.image.large))
                .clipped()
                .overlay {
                    LinearGradient(
                        colors: [
                            Color(uiColor: .systemBackground).opacity(0.001),
                            Color(uiColor: .systemBackground)
                        ],
                        startPoint: .center,
                        endPoint: .bottom
                    )
                }

            VStack(spacing: 16) {
                Text("Overview")
                    .font(.title)
                    .fontWeight(.bold)
                Text(viewModel.movie.overView)
                    .font(.body)
            }
            .offset(y: -80)
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(viewModel.movie.title)
    }
}

struct MovieDetailsScreem_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MovieDetailsScreen(viewModel: MockMovieDetailsViewModel())
                .preferredColorScheme(.light)
            MovieDetailsScreen(viewModel: MockMovieDetailsViewModel())
                .preferredColorScheme(.dark)
        }
    }
}
