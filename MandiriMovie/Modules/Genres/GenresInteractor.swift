//
//  GenresInteractor.swift
//  MandiriMovie
//
//  Created by ITUMAC02 on 03/06/26.
//

import Foundation

final class GenresInteractor: GenresPresenterToInteractorProtocol {
    
    private let apiService: APIServiceProtocol
    
    init(apiService: APIServiceProtocol = APIService.shared) {
        self.apiService = apiService
    }
    
    func fetchGenres() async throws -> [Genre] {
        let response = try await apiService.request(endpoint: .genres) as GenreResponse
        return response.genres
    }
}
