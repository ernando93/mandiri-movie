//
//  MovieDetailPresenter.swift
//  MandiriMovie
//
//  Created by ITUMAC02 on 04/06/26.
//

import Foundation

final class MovieDetailPresenter: MovieDetailViewToPresenterProtocol {
    
    var view: MovieDetailPresenterToViewProtocol?
    var interactor: MovieDetailPresenterToInteractorProtocol?
    var router: MovieDetailPresenterToRouterProtocol?
    
    private let movieId: Int
    private var trailerKey: String?

    init(movieId: Int) {
        self.movieId = movieId
    }

    func viewDidLoad() {
        Task { await loadAll() }
    }

    @MainActor
    private func loadAll() async {
        view?.showLoading()
        defer { view?.hideLoading() }

        do {
            guard let interactor else {
                return
            }
            async let detail = interactor.fetchMovieDetail(movieId: movieId)
            async let reviews = interactor.fetchReviews(movieId: movieId, page: 1)
            async let videos = interactor.fetchVideos(movieId: movieId)

            let (movieDetail, reviewsResult, videoResult) = try await (detail, reviews, videos)

            view?.showMovieDetail(movieDetail)
            view?.showReviews(reviewsResult.0)
            view?.showTrailer(videoResult.first(where: { $0.isYouTubeTrailer })?.key)

            trailerKey = videoResult.first(where: { $0.isYouTubeTrailer })?.key
        } catch {
            view?.showError(error.localizedDescription)
        }
    }
    
    func loadNextReviewPage() {
        print(#function)
    }
    
    func didTapWatchTrailer() {
        guard let trailerKey else { return }
        router?.openTrailer(videoKey: trailerKey)
    }
    
    func didTapSeeAllReviews() {
        print(#function)
    }
}
