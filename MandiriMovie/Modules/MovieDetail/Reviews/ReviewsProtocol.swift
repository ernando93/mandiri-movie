//
//  ReviewsProtocol.swift
//  MandiriMovie
//
//  Created by ITUMAC02 on 05/06/26.
//

import UIKit

//MARK: - Presenter -> Router
protocol ReviewsPresenterToRouterProtocol: AnyObject {
    static func createModule(movieId: Int) -> UIViewController
}

// MARK: - View -> Presenter
protocol ReviewsViewToPresenterProtocol: AnyObject {
    var view: ReviewsPresenterToViewProtocol? { get set }
    var interactor: ReviewsPresenterToInteractorProtocol? { get set }
    var router: ReviewsPresenterToRouterProtocol? { get set }

    func viewDidLoad()
    func didPullToRefresh()
    func loadNextPage()
}

// MARK: - Presenter -> Interactor
protocol ReviewsPresenterToInteractorProtocol: AnyObject {
    func fetchReviews(movieId: Int, page: Int) async throws -> ([Review], Int)
}

// MARK: - Presenter -> View
protocol ReviewsPresenterToViewProtocol: AnyObject {
    func showReviews(_ reviews: [Review], replace: Bool)
    func showError(_ message: String)
    func showLoading()
    func hideLoading()
}

