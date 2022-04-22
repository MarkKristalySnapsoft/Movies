//
//  MovieServiceMock.swift
//  MoviesTests
//
//  Created by Márk Kristály on 2022. 04. 22..
//

import Combine
import XCTest
@testable import Movies

class MovieServiceMock: MovieServiceProtocol {
    func getTrendingMovies(page: Int) -> AnyPublisher<MovieListResponse, Error> {
        Just(MovieListResponse(
            page: page,
            results: [
                Movie(id: 1, title: "Test title 1", genreIds: [1, 2], overview: "Test overview 1", voteAverage: 8.9, posterPath: "testpath1"),
                Movie(id: 2, title: "Test title 2", genreIds: [3, 2], overview: "Test overview 2", voteAverage: 8.1, posterPath: "testpath2"),
                Movie(id: 3, title: "Test title 3", genreIds: [1], overview: "Test overview 3", voteAverage: 1.9, posterPath: "testpath3"),
            ],
            totalPages: 3,
            totalResults: 30)
        )
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()
    }
    
    func getGenres() -> AnyPublisher<GenreResponse, Error> {
        Just(GenreResponse(genres: [
            Genre(id: 1, name: "Test genre 1"),
            Genre(id: 2, name: "Test genre 2"),
            Genre(id: 3, name: "Test genre 3"),
        ]))
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()
    }
    
    func getImageConfigurations() -> AnyPublisher<ImageConfiguration, Error> {
        Just(ImageConfiguration(secureBaseUrl: "https://testsecurebaseurl.com", posterSizes: [.w92, .w342]))
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
