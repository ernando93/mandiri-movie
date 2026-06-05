//
//  MovieDetailProtocol.swift
//  MandiriMovie
//
//  Created by ITUMAC02 on 04/06/26.
//

import Foundation

import UIKit

// MARK: - View -> Presenter
protocol MovieDetailViewToPresenterProtocol: AnyObject {
    var view: MovieDetailPresenterToViewProtocol? { get set }
    var interactor: MovieDetailPresenterToInteractorProtocol? { get set }
    var router: MovieDetailPresenterToRouterProtocol? { get set }

    func viewDidLoad()
    func didTapWatchTrailer()
    func didTapSeeAllReviews()
}

// MARK: - Presenter -> View
protocol MovieDetailPresenterToViewProtocol: AnyObject {
    func showMovieDetail(_ detail: MovieDetail)
    func showReviews(_ reviews: [Review], totalReviews: Int)
    func showTrailer(_ trailerKey: String?)
    func showError(_ message: String)
    func showLoading()
    func hideLoading()
}

// MARK: - Presenter -> Interactor
protocol MovieDetailPresenterToInteractorProtocol: AnyObject {
    func fetchMovieDetail(movieId: Int) async throws -> MovieDetail
    func fetchReviews(movieId: Int, page: Int) async throws -> ([Review], Int)
    func fetchVideos(movieId: Int) async throws -> [Video]
}

// MARK: - Presenter -> Router
protocol MovieDetailPresenterToRouterProtocol: AnyObject {
    static func createModule(movieId: Int) -> UIViewController
    func openTrailer(videoKey: String)
    func navigateToAllReviews(view: MovieDetailPresenterToViewProtocol, movieId: Int)
}
