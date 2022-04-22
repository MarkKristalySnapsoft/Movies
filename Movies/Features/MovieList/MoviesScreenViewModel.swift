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
    @Published var isLoading: Bool = false
    @Published var error: Error? = nil
    @Published var hasError: Bool = false
    
    private let movieStore: MoviesStoreProtocol
    private let moviesActions: MoviesActions
    
    private var page = 0
    private var maxPage = 1
    private var subscriptions = Set<AnyCancellable>()
    
    init(movieStore: MoviesStoreProtocol, moviesActions: MoviesActions) {
        self.movieStore = movieStore
        self.moviesActions = moviesActions
        
        setupBindings()
        loadMore()
    }
    
    func loadMore() {
        guard page < maxPage, !isLoading else { return }
        isLoading = true
        page += 1
        moviesActions.getMovieInfos(for: page)
    }
    
    private func setupBindings() {
        Publishers.CombineLatest4(movieStore.moviesPublisher, movieStore.genresPublisher, movieStore.imageConfigurationPublisher, movieStore.maxPagePublisher)
            .sink { [weak self] movies, genres, imageConfiguration, maxPage in
                guard let self = self else { return }
                
                self.movies = movies.map { movie in
                    let genres = self.getGenresByIds(movie.genreIds, genres: genres)
                    return MovieVM(id: "\(movie.id)", title: movie.title, genres: genres, overView: movie.overview, image: self.getMovieVMImage(configuration: imageConfiguration, movie: movie), popularity: movie.voteAverage)
                }
                self.maxPage = maxPage
                self.isLoading = false
            }
            .store(in: &subscriptions)
        
        movieStore.latestError.sink { [weak self] error in
            self?.error = error
            self?.hasError = true
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
