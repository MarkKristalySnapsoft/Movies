//
//  Genre.swift
//  Movies
//
//  Created by Márk Kristály on 2022. 04. 20..
//

import Foundation

struct Genre {
    let id: Int
    let name: String
}

extension Genre: Decodable {}
extension Genre: Equatable {}
