//
//  MoviesViewModel.swift
//  Movies
//
//  Created by Foundation on 2022. 02. 14..
//

import Combine
import Foundation

class MoviesScreenViewModel: ObservableObject, MoviesScreenViewModelProtocol {
    @Published var movies: [MovieVM] = []
    
    private let movieStore: MoviesStoreProtocol = MoviesStore.shared
    private let moviesActions: MoviesActions = MoviesActions.shared
    
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        setupBindings()
        moviesActions.getMovieInfos()
    }
    
    private func setupBindings() {
        Publishers.CombineLatest3(movieStore.moviesPublisher, movieStore.genresPublisher, movieStore.imageConfigurationPublisher)
            .sink { [weak self] movies, genres, imageConfiguration in
                guard let self = self else { return }
                
                self.movies = movies.map { movie in
                    let genres = self.getGenresByIds(movie.genreIds, genres: genres)
                    return MovieVM(id: "\(movie.id)", title: movie.title, genres: genres, overView: movie.overview, image: self.getMovieVMImage(configuration: imageConfiguration, movie: movie), popularity: movie.popularity)
                }
            }
            .store(in: &subscriptions)
    }
    
    private func getGenresByIds(_ genreIds: [Int], genres: [Genre]) -> String {
        genres
            .filter { genreIds.contains($0.id) }
            .map { $0.name }
            .joined(separator: ", ")
    }
    
    private func getMovieVMImage(configuration: ImageConfiguration, movie: Movie) -> MovieVM.Image {
        guard let smallSize = configuration.posterSizes.first, let largeSize = configuration.posterSizes.last, let posterPath = movie.posterPath else {
            return MovieVM.Image(small: "", large: "")
        }
        
        return MovieVM.Image(
            small: "\(configuration.secureBaseUrl)\(smallSize)/\(posterPath)",
            large: "\(configuration.secureBaseUrl)\(largeSize)/\(posterPath)")
    }
}
