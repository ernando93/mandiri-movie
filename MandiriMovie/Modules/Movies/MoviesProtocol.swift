//
//  MoviesProtocol.swift
//  MandiriMovie
//
//  Created by ITUMAC02 on 03/06/26.
//

import UIKit

//MARK: - Presenter -> Router
protocol MoviesPresenterToRouterProtocol: AnyObject {
    static func createModule(genre: Genre) -> UIViewController
    func navigateToMovieDetail(id: Int)
}

//MARK: - View -> Presenter
protocol MoviesViewToPresenterProtocol: AnyObject {
    var view: MoviesPresenterToViewProtocol? { get set }
    var interactor: MoviesPresenterToInteractorProtocol? { get set }
    var router: MoviesPresenterToRouterProtocol? { get set }
    
    func viewDidLoad()
    func didSelectMovie(_ movie: Movie)
    func didPullToRefresh()
}

//MARK: - Presenter -> Interactor
protocol MoviesPresenterToInteractorProtocol: AnyObject {
    func fetchMovies(genreId: Int, page: Int) async throws -> ([Movie], Int)
}

//MARK: - Presenter -> View
protocol MoviesPresenterToViewProtocol: AnyObject {
    func showMovies(_ movies: [Movie], replace: Bool)
    func showError(_ message: String)
    func showLoading()
    func hideLoading()
}
