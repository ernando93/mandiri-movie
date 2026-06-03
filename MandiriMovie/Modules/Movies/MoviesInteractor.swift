//
//  MoviesInteractor.swift
//  MandiriMovie
//
//  Created by ITUMAC02 on 03/06/26.
//

import Foundation

final class MoviesInteractor: MoviesPresenterToInteractorProtocol {
    
    private let apiService: APIServiceProtocol
    
    init(apiService: APIServiceProtocol = APIService.shared) {
        self.apiService = apiService
    }
    
    func fetchMovies(genreId: Int, page: Int) async throws -> ([Movie], Int) {
        let response = try await apiService.request(endpoint: .discoverMovies(genreId: genreId, page: page)) as MovieResponse
        return (response.movies, response.totalPages)
    }
}
