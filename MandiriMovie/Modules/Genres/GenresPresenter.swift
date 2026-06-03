//
//  GenresPresenter.swift
//  MandiriMovie
//
//  Created by ITUMAC02 on 03/06/26.
//

import Foundation

final class GenresPresenter: GenresViewToPresenterProtocol {
    weak var view: GenresPresenterToViewProtocol?
    var interactor: GenresPresenterToInteractorProtocol?
    var router: GenresPresenterToRouterProtocol?
    
    func viewDidLoad() {
        Task {
            await loadGenres()
        }
    }
    
    private func loadGenres() async {
        view?.showLoading()
        
        defer {
            view?.hideLoading()
        }
        
        do {
            guard let interactor else { return }
            let genres = try await interactor.fetchGenres()
            view?.showGenres(genres)
        } catch {
            view?.showError(error.localizedDescription)
        }
    }
    
    
    func didSelectGenre(_ genre: Genre) {
        guard let view = view else { return }
        router?.navigateToMovieList(from: view, genre: genre)
    }
}
