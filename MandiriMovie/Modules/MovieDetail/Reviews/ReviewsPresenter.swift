//
//  ReviewsPresenter.swift
//  MandiriMovie
//
//  Created by ITUMAC02 on 05/06/26.
//

import Foundation

final class ReviewsPresenter: ReviewsViewToPresenterProtocol {
    weak var view: ReviewsPresenterToViewProtocol?
    var interactor: ReviewsPresenterToInteractorProtocol?
    var router: ReviewsPresenterToRouterProtocol?
    
    private let movieId: Int
    private let pagination = PaginationHelper()

    init(movieId: Int) {
        self.movieId = movieId
    }
    
    func viewDidLoad() {
        Task {
            await loadReviews()
        }
    }
    
    private func loadReviews() async {
        if pagination.currentPage == 1 {
            view?.showLoading()
        }
        
        defer {
            view?.hideLoading()
        }
        
        do {
            guard let interactor else { return }
            let (reviews, totalPages) = try await interactor.fetchReviews(movieId: movieId, page: pagination.currentPage)
            pagination.finishFetching(totalPages: totalPages)
            let isFirstLoad = pagination.currentPage == 2
            
            if isFirstLoad && reviews.isEmpty {
                //show empty layout
            } else {
                await MainActor.run {
                    view?.showReviews(reviews, replace: isFirstLoad)
                }
            }
        } catch {
            view?.showError(error.localizedDescription)
        }
    }
    
    func didPullToRefresh() {
        pagination.reset()
        Task {
            await loadReviews()
        }
    }
    
    func loadNextPage() {
        guard pagination.canLoadMore else { return }
        pagination.startFetching()
        Task {
            await loadReviews()
        }
    }
}
