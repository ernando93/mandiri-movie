//
//  MoviesPresenter.swift
//  MandiriMovie
//
//  Created by ITUMAC02 on 03/06/26.
//

import Foundation

final class MoviesPresenter: MoviesViewToPresenterProtocol {
    weak var view: MoviesPresenterToViewProtocol?
    var interactor: MoviesPresenterToInteractorProtocol?
    var router: MoviesPresenterToRouterProtocol?
    
    private var genre: Genre
    private let pagination = PaginationHelper()
    
    init(genre: Genre) {
        self.genre = genre
    }
    
    func viewDidLoad() {
        Task {
            await loadMovies()
        }
    }
    
    func loadNextPage() {
        guard pagination.canLoadMore else { return }
        pagination.startFetching()
        Task {
            await loadMovies()
        }
    }
    
    private func loadMovies() async {
        view?.showLoading()
        
        defer {
            view?.hideLoading()
        }
        
        do {
            guard let interactor else { return }
            let (movies, totalPages) = try await interactor.fetchMovies(genreId: genre.id, page: pagination.currentPage)
            pagination.finishFetching(totalPages: totalPages)
            let isFirstLoad = pagination.currentPage == 2

            if isFirstLoad && movies.isEmpty {
                //show empty layout
            } else {
                await MainActor.run {
                    view?.showMovies(movies, replace: isFirstLoad)
                }
            }
        } catch {
            view?.showError(error.localizedDescription)
        }
    }
    
    func didSelectMovie(_ movie: Movie) {
        print(#function)
    }
    
    func didPullToRefresh() {
        pagination.reset()
        Task {
            await loadMovies()
        }
    }
}
