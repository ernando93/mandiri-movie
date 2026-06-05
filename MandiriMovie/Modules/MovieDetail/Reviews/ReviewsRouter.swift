//
//  ReviewsRouter.swift
//  MandiriMovie
//
//  Created by ITUMAC02 on 05/06/26.
//

import UIKit

final class ReviewsRouter: ReviewsPresenterToRouterProtocol {
    static func createModule(movieId: Int) -> UIViewController {
        let view = ReviewsViewController()
        let presenter = ReviewsPresenter(movieId: movieId)
        let interactor = ReviewsInteractor()
        let router = ReviewsRouter()

        view.title = "Reviews"
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        return view
    }
}
