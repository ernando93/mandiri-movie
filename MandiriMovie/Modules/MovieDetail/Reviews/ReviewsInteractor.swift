//
//  ReviewsInteractor.swift
//  MandiriMovie
//
//  Created by ITUMAC02 on 05/06/26.
//

import Foundation

final class ReviewsInteractor: ReviewsPresenterToInteractorProtocol {
    
    private let apiService: APIServiceProtocol
    
    init(apiService: APIServiceProtocol = APIService.shared) {
        self.apiService = apiService
    }
    
    func fetchReviews(movieId: Int, page: Int) async throws -> ([Review], Int) {
        let  response = try await apiService.request(endpoint: .reviews(movieId: movieId, page: page)) as ReviewResponse
        return (response.results, response.totalPages)
    }
}
