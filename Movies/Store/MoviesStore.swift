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
    var maxPagePublisher: AnyPublisher<Int, Never> { get }
    var latestError: AnyPublisher<Error, Never> { get }
    
    func setGenres(_ genres: [Genre])
    func appendMovies(_ movies: [Movie])
    func setImageConfiguration(_ imageConfiguration: ImageConfiguration)
    func setMaxPage(_ maxPage: Int)
    func setError(_ error: Error?)
}

class MoviesStore: MoviesStoreProtocol {
    var maxPagePublisher: AnyPublisher<Int, Never> {
        maxPageSubject
            .removeDuplicates()
            .eraseToAnyPublisher()
    }
    
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
    private let maxPageSubject = CurrentValueSubject<Int, Never>(1)
    private let errorSubject = CurrentValueSubject<Error?, Never>(nil)
    
    static let shared: MoviesStoreProtocol = MoviesStore()
    
    init() {}
    
    func setGenres(_ genres: [Genre]) {
        genresSubject.send(genres)
    }
    
    func appendMovies(_ movies: [Movie]) {
        var updatedMovies = moviesSubject.value
        updatedMovies.append(contentsOf: movies)
        moviesSubject.send(updatedMovies)
    }
    
    func setImageConfiguration(_ imageConfiguration: ImageConfiguration) {
        imageConfigurationSubject.send(imageConfiguration)
    }
    
    func setError(_ error: Error?) {
        errorSubject.send(error)
    }
    
    func setMaxPage(_ maxPage: Int) {
        maxPageSubject.send(maxPage)
    }
}
