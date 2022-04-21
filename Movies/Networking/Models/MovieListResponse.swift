//
//  MovieListResponse.swift
//  Movies
//
//  Created by Márk Kristály on 2022. 04. 20..
//

import Foundation

struct MovieListResponse {
    var page: Int
    var results: [Movie]
    var totalPages: Int
    var totalResults: Int
}

extension MovieListResponse: Decodable {
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
