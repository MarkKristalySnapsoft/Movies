//
//  GenreResponse.swift
//  Movies
//
//  Created by Márk Kristály on 2022. 04. 20..
//

import Foundation

struct GenreResponse {
    let genres: [Genre]
}

extension GenreResponse: Decodable {}
