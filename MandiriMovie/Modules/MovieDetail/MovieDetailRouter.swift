//
//  MovieDetailRouter.swift
//  MandiriMovie
//
//  Created by ITUMAC02 on 04/06/26.
//

import UIKit

final class MovieDetailRouter: MovieDetailPresenterToRouterProtocol {
    static func createModule(movieId: Int) -> UIViewController {
        let view = MovieDetailViewController()
        let presenter = MovieDetailPresenter(movieId: movieId)
        let interactor = MovieDetailInteractor()
        let router = MovieDetailRouter()

        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        return view
    }
    
    func openTrailer(videoKey: String) {
        guard let url = URL(string: "https://www.youtube.com/watch?v=\(videoKey)") else { return }
        UIApplication.shared.open(url)
    }
    
    func navigateToAllReviews(movieId: Int) {
        print(#function)
    }
}
