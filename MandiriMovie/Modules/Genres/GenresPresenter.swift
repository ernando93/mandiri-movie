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
            do {
                guard let interactor else { return }
                let genres = try await interactor.fetchGenres()
                
                await MainActor.run {
                    print("Genres: \(genres)")
                    view?.showGenres(genres)
                }
            } catch {
                await MainActor.run {
                    view?.showError(error.localizedDescription)
                }
            }
        }
    }
    
    func didSelectGenre(_ genre: Genre) {
        print("didSelectGenre")
    }
}
