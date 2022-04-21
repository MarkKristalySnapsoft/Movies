//
//  MovieService.swift
//  Movies
//
//  Created by Márk Kristály on 2022. 04. 20..
//

import Combine
import CombineMoya
import Moya

protocol MovieServiceProtocol {
    func getTrendingMovies() -> AnyPublisher<MovieListResponse, Error>
    func getGenres() -> AnyPublisher<GenreResponse, Error>
    func getImageConfigurations() -> AnyPublisher<ImageConfiguration, Error>
}

class MovieService: MovieServiceProtocol {
    private let provider = MoyaProvider<Movies>()
    
    func getTrendingMovies() -> AnyPublisher<MovieListResponse, Error> {
        provider.requestPublisher(.ratedMovies)
            .tryMap { response in
                try response.map(MovieListResponse.self)
            }
            .eraseToAnyPublisher()
    }
    
    func getGenres() -> AnyPublisher<GenreResponse, Error> {
        provider.requestPublisher(.genres)
            .tryMap { response in
                try response.map(GenreResponse.self)
            }
            .eraseToAnyPublisher()
    }
    
    func getImageConfigurations() -> AnyPublisher<ImageConfiguration, Error> {
        provider.requestPublisher(.imageConfiguration)
            .tryMap { response in
                let imageConfigurationResponse = try response.map(ImageConfigurationResponse.self)
                return imageConfigurationResponse.images
            }
            .eraseToAnyPublisher()
    }
}
