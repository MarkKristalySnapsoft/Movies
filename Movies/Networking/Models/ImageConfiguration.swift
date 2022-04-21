//
//  ImageConfiguration.swift
//  Movies
//
//  Created by Márk Kristály on 2022. 04. 21..
//

import Foundation

enum PosterSize: String {
    case w92 = "w92"
    case W154 = "w154"
    case w185 = "w185"
    case w342 = "w342"
    case w500 = "w500"
    case w780 = "w780"
    case original = "original"
}

extension PosterSize: Decodable {}
extension PosterSize: Equatable {}

struct ImageConfiguration {
    let secureBaseUrl: String
    let posterSizes: [PosterSize]
}

extension ImageConfiguration: Decodable {
    enum CodingKeys: String, CodingKey {
        case secureBaseUrl = "secure_base_url"
        case posterSizes = "poster_sizes"
    }
}

extension ImageConfiguration: Equatable {}
