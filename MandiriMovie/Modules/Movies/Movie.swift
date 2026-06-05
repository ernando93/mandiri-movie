//
//  Movie.swift
//  MandiriMovie
//
//  Created by ITUMAC02 on 03/06/26.
//

import Foundation

struct Movie: Decodable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    let backdropPath: String?
    let voteAverage: Double
    let voteCount: Int
    let releaseDate: String
    let genreIds: [Int]?
    
    var posterURL: URL? {
        guard let path = posterPath else { return nil }
        return URL(string: APIConstants.imageBaseW500 + path)
    }

    var backdropURL: URL? {
        guard let path = backdropPath else { return nil }
        return URL(string: APIConstants.imageBaseOriginal + path)
    }

    var formattedRating: String {
        String(format: "%.1f", voteAverage)
    }
}

struct MovieResponse: Decodable {
    let results: [Movie]
    let page: Int
    let totalPages: Int
    let totalResults: Int
}
