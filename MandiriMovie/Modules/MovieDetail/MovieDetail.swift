//
//  MovieDetail.swift
//  MandiriMovie
//
//  Created by ITUMAC02 on 04/06/26.
//

import Foundation

// MARK: - Movie Detail
struct MovieDetail: Decodable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    let backdropPath: String?
    let voteAverage: Double
    let voteCount: Int
    let releaseDate: String
    let runtime: Int?
    let status: String
    let tagline: String?
    let genres: [GenreItem]

    struct GenreItem: Decodable {
        let id: Int
        let name: String
    }

    var posterURL: URL? {
        guard let path = posterPath else { return nil }
        return URL(string: APIConstants.imageBaseW500 + path)
    }

    var backdropURL: URL? {
        guard let path = backdropPath else { return nil }
        return URL(string: APIConstants.imageBaseOriginal + path)
    }

    var formattedRating: String { String(format: "%.1f", voteAverage) }
    var formattedRuntime: String {
        guard let runtime = runtime else { return "N/A" }
        return "\(runtime / 60)h \(runtime % 60)m"
    }
    var genreNames: String { genres.map { $0.name }.joined(separator: " • ") }
}

// MARK: - Review
struct Review: Decodable {
    let id: String
    let author: String
    let content: String
    let createdAt: String
    let authorDetails: AuthorDetails?

    var formattedDate: String {
        let iso = ISO8601DateFormatter()
        iso.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        if let date = iso.date(from: createdAt) {
            let display = DateFormatter()
            display.dateFormat = "MMM d, yyyy"
            return display.string(from: date)
        }
        iso.formatOptions = [.withInternetDateTime]
        if let date = iso.date(from: createdAt) {
            let display = DateFormatter()
            display.dateFormat = "MMM d, yyyy"
            return display.string(from: date)
        }
        return createdAt
    }
    
    struct AuthorDetails: Decodable {
        let rating: Double?
        let avatarPath: String?

        var avatarURL: URL? {
            guard var path = avatarPath else { return nil }
            if path.hasPrefix("/http") { path = String(path.dropFirst()) }
            return URL(string: path)
        }
    }
}

struct ReviewResponse: Decodable {
    let results: [Review]
    let page: Int
    let totalPages: Int
}

// MARK: - Video
struct Video: Decodable {
    let id: String
    let key: String
    let name: String
    let site: String
    let type: String

    var isYouTubeTrailer: Bool {
        return site == "YouTube" && type == "Trailer"
    }

    var youtubeURL: URL? {
        URL(string: "https://www.youtube.com/embed/\(key)?playsinline=1")
    }
}

struct VideoResponse: Decodable {
    let id: Int
    let results: [Video]
}
