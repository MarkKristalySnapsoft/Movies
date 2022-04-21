//
//  MoviesStore.swift
//  Movies
//
//  Created by Márk Kristály on 2022. 04. 20..
//

import Combine
import Foundation

protocol MoviesStoreProtocol: AnyObject {
    var genresPublisher: AnyPublisher<[Genre], Never> { get }
    var moviesPublisher: AnyPublisher<[Movie], Never> { get }
    var imageConfigurationPublisher: AnyPublisher<ImageConfiguration, Never> { get }
    var latestError: AnyPublisher<Error, Never> { get }
    
    func setGenres(_ genres: [Genre])
    func setMovies(_ movies: [Movie])
    func setImageConfiguration(_ imageConfiguration: ImageConfiguration)
    func setError(_ error: Error?)
}

class MoviesStore: MoviesStoreProtocol {
    var genresPublisher: AnyPublisher<[Genre], Never> {
        genresSubject
            .removeDuplicates()
            .eraseToAnyPublisher()
    }
    
    var moviesPublisher: AnyPublisher<[Movie], Never> {
        moviesSubject
            .removeDuplicates()
            .eraseToAnyPublisher()
    }
    
    var imageConfigurationPublisher: AnyPublisher<ImageConfiguration, Never> {
        imageConfigurationSubject.compactMap { $0 }
            .removeDuplicates()
            .eraseToAnyPublisher()
    }
    
    // Use this to show errors
    var latestError: AnyPublisher<Error, Never> {
        errorSubject.compactMap { $0 }
            .eraseToAnyPublisher()
    }
    
    private let genresSubject = CurrentValueSubject<[Genre], Never>([])
    private let moviesSubject = CurrentValueSubject<[Movie], Never>([])
    private let imageConfigurationSubject = CurrentValueSubject<ImageConfiguration?, Never>(nil)
    private let errorSubject = CurrentValueSubject<Error?, Never>(nil)
    
    static let shared: MoviesStoreProtocol = MoviesStore()
    
    private init() {}
    
    func setGenres(_ genres: [Genre]) {
        genresSubject.send(genres)
    }
    
    func setMovies(_ movies: [Movie]) {
        moviesSubject.send(movies)
    }
    
    func setImageConfiguration(_ imageConfiguration: ImageConfiguration) {
        imageConfigurationSubject.send(imageConfiguration)
    }
    
    func setError(_ error: Error?) {
        errorSubject.send(error)
    }
}
