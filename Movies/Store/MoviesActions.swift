//
//  MoviesActions.swift
//  Movies
//
//  Created by Márk Kristály on 2022. 04. 20..
//

import Combine

class MoviesActions {
    private let movieStore: MoviesStoreProtocol
    private let movieService: MovieServiceProtocol
    
    static let shared = MoviesActions(movieStore: MoviesStore.shared, movieService: MovieService())
    
    private var subscriptions = Set<AnyCancellable>()
    
    private init(movieStore: MoviesStoreProtocol, movieService: MovieServiceProtocol) {
        self.movieStore = movieStore
        self.movieService = movieService
    }
    
    func getMovieInfos() {
        movieService.getTrendingMovies().sink(
            receiveCompletion: { [weak self] completion in
                guard case let .failure(error) = completion else { return }
                self?.movieStore.setError(error)
            }, receiveValue: { [weak self] movies in
                self?.movieStore.setMovies(movies.results)
            })
        .store(in: &subscriptions)
        
        movieService.getGenres().sink(
            receiveCompletion: { [weak self] completion in
                guard case let .failure(error) = completion else { return }
                self?.movieStore.setError(error)
            }, receiveValue: { [weak self] genresReponse in
                self?.movieStore.setGenres(genresReponse.genres)
            })
        .store(in: &subscriptions)
        
        movieService.getImageConfigurations().sink(
            receiveCompletion: { [weak self] completion in
                guard case let .failure(error) = completion else { return }
                self?.movieStore.setError(error)
            }, receiveValue: { [weak self] imageConfiguration in
                self?.movieStore.setImageConfiguration(imageConfiguration)
            })
        .store(in: &subscriptions)
    }
}
