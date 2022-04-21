//
//  Movies.swift
//  Movies
//
//  Created by Márk Kristály on 2022. 04. 20..
//

import Foundation
import Moya

enum Movies {
    case imageConfiguration
    case ratedMovies
    case genres
}

extension Movies: TargetType {
    var baseURL: URL {
        URL(string: moviesBaseUrl)!
    }
    
    var path: String {
        switch self {
        case .ratedMovies:
            return "movie/top_rated"
        case .imageConfiguration:
            return "configuration"
        case .genres:
            return "genre/movie/list"
        }
    }
    
    var method: Moya.Method {
        Moya.Method.get
    }
    
    var task: Task {
        .requestParameters(parameters: ["api_key": APIkey], encoding: URLEncoding.queryString)
    }
    
    var headers: [String : String]? {
        nil
    }
}
