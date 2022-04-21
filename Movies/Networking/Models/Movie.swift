//
//  Movie.swift
//  Movies
//
//  Created by Márk Kristály on 2022. 04. 20..
//

import Foundation

struct Movie {
    let id: Int
    let title: String
    let genreIds: [Int]
    let overview: String
    let popularity: Float
    let posterPath: String?
}

extension Movie: Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case genreIds = "genre_ids"
        case overview
        case popularity
        case posterPath = "poster_path"
    }
}

extension Movie: Equatable {}
