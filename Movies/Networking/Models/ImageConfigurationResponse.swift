//
//  ImageConfigurationResponse.swift
//  Movies
//
//  Created by Márk Kristály on 2022. 04. 21..
//

import Foundation

struct ImageConfigurationResponse {
    let images: ImageConfiguration
}

extension ImageConfigurationResponse: Decodable {}
