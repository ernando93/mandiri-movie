//
//  APIEndpoint.swift
//  MandiriMovie
//
//  Created by ITUMAC02 on 03/06/26.
//


import Foundation

enum APIEndpoint {
    case genres
    case discoverMovies(genreId: Int, page: Int)
    case movieDetails(id: Int)
    case reviews(movieId: Int, page: Int)
    case videos(movieId: Int)
    
    var url: URL? {
        let baseURL   = APIConstants.baseURL
        let apiKey    = APIConfiguration.apiKey
        let path: String = {
            switch self {
            case .genres:
                return "/genre/movie/list?api_key=\(apiKey)"
            case .discoverMovies(let genreId, let page):
                return "/discover/movie?api_key=\(apiKey)&with_genres=\(genreId)&page=\(page)&sort_by=popularity.desc"
            case .movieDetails(let id):
                return "/movie/\(id)?api_key=\(apiKey)"
            case .reviews(let movieId, let page):
                return "/movie/\(movieId)/reviews?api_key=\(apiKey)&page=\(page)"
            case .videos(let movieId):
                return "/movie/\(movieId)/videos?api_key=\(apiKey)"
            }
        }()
        
        return URL(string: baseURL + path)
    }
}
