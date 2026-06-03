//
//  GenresProtocol.swift
//  MandiriMovie
//
//  Created by ITUMAC02 on 03/06/26.
//

import UIKit

//MARK: - Presenter -> Router
protocol GenresPresenterToRouterProtocol: AnyObject {
    static func createModule() -> UIViewController
    func navigateToMovieList()
}

// MARK: - View → Presenter
protocol GenresViewToPresenterProtocol: AnyObject {
    var view: GenresPresenterToViewProtocol? { get set }
    var interactor: GenresPresenterToInteractorProtocol? { get set }
    var router: GenresPresenterToRouterProtocol? { get set }

    func viewDidLoad()
    func didSelectGenre(_ genre: Genre)
}

// MARK: - Presenter → Interactor
protocol GenresPresenterToInteractorProtocol: AnyObject {
    func fetchGenres() async throws -> [Genre]
}

// MARK: - Presenter → View
protocol GenresPresenterToViewProtocol: AnyObject {
    func showGenres(_ genres: [Genre])
    func showError(_ message: String)
    func showLoading()
    func hideLoading()
}
