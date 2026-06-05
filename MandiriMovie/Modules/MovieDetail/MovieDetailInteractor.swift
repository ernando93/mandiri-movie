//
//  MovieDetailInteractor.swift
//  MandiriMovie
//
//  Created by ITUMAC02 on 04/06/26.
//

final class MovieDetailInteractor: MovieDetailPresenterToInteractorProtocol {
    
    private let apiService: APIServiceProtocol
    
    init(apiService: APIServiceProtocol = APIService.shared) {
        self.apiService = apiService
    }
    
    func fetchMovieDetail(movieId: Int) async throws -> MovieDetail {
        return try await apiService.request(endpoint: .movieDetails(id: movieId)) as MovieDetail
    }
    
    func fetchReviews(movieId: Int, page: Int) async throws -> ([Review], Int) {
        let  response = try await apiService.request(endpoint: .reviews(movieId: movieId, page: page)) as ReviewResponse
        return (response.results, response.totalResults)
    }
    
    func fetchVideos(movieId: Int) async throws -> [Video] {
        let response = try await apiService.request(endpoint: .videos(movieId: movieId)) as VideoResponse
        return response.results
    }
}
