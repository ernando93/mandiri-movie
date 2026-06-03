//
//  GenresRouter.swift
//  MandiriMovie
//
//  Created by ITUMAC02 on 03/06/26.
//

import UIKit

final class GenresRouter: GenresPresenterToRouterProtocol {
    static func createModule() -> UIViewController {
        let view = GenresViewController()
        let presenter = GenresPresenter()
        let interactor = GenresInteractor()
        let router = GenresRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        return UINavigationController(rootViewController: view)
    }
    
    func navigateToMovieList() {
        print("Navigate to MovieList")
    }
}
