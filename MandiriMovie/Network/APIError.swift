//
//  APIError.swift
//  MandiriMovie
//
//  Created by ITUMAC02 on 03/06/26.
//

import Foundation

enum APIError: Error, LocalizedError {
    case invalidURL
    case invalidResponse
    case serverError(Int)
    case decodingError(Error)
    case networkError(Error)

    var errorDescription: String? {
        switch self {
        case .invalidURL: 
            return "Invalid URL."
        case .invalidResponse:
            return "Invalid response from server."
        case .serverError(let code):
            return "Server error. Code: \(code)"
        case .decodingError(let err): 
            return "Decoding error: \(err.localizedDescription)"
        case .networkError(let err): 
            return "Network error: \(err.localizedDescription)"
        }
    }
}
