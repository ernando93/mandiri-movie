//
//  MoviesRouter.swift
//  MandiriMovie
//
//  Created by ITUMAC02 on 03/06/26.
//

import UIKit

final class MoviesRouter: MoviesPresenterToRouterProtocol {
    static func createModule(genre: Genre) -> UIViewController {
        let view = MoviesViewController()
        let presenter = MoviesPresenter(genre: genre)
        let interactor = MoviesInteractor()
        let router = MoviesRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        view.title = genre.name
        return view
    }
    
    func navigateToMovieDetail(id: Int) {
        print(#function)
    }
}
