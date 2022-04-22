//
//  MoviesTests.swift
//  MoviesTests
//
//  Created by Márk Kristály on 2022. 04. 22..
//

import Combine
import XCTest
@testable import Movies

class MoviesTests: XCTestCase {
    var movieService: MovieServiceProtocol = MovieServiceMock()
    var moviesScreenViewModel: MoviesScreenViewModel!
    
    private var subscriptions = Set<AnyCancellable>()
    
    func testMovieScreenViewModelMovies() throws {
        let expectation = XCTestExpectation(description: "isLoading should be true after loadMore()")
        
        let movieStore = MoviesStore()
        let moviesActions = MoviesActions(movieStore: movieStore, movieService: movieService)
        moviesScreenViewModel = MoviesScreenViewModel(movieStore: movieStore, moviesActions: moviesActions)
        
        moviesScreenViewModel.$isLoading.sink { isLoading in
            if isLoading {
                expectation.fulfill()
            }
        }.store(in: &subscriptions)
        
        XCTAssert(moviesScreenViewModel.movies.count == 3)
        
        moviesScreenViewModel.loadMore()
        wait(for: [expectation], timeout: 1)
        XCTAssert(moviesScreenViewModel.movies.count == 6)
    }
}
