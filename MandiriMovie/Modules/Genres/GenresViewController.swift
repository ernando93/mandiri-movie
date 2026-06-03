//
//  GenresViewController.swift
//  MandiriMovie
//
//  Created by ITUMAC02 on 03/06/26.
//

import UIKit

final class GenresViewController: UIViewController {
    
    var presenter: GenresViewToPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.viewDidLoad()
    }
    
    private func setupUI() {
        title = "Movie Genres"
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

//MARK: - GenresPresenterToViewProtocol
extension GenresViewController: GenresPresenterToViewProtocol {
    func showGenres(_ genres: [Genre]) {
        print("Show Genres")
    }
    
    func showError(_ message: String) {
        print("show Error")
    }
    
    func showLoading() {
        print("Show Loading")
    }
    
    func hideLoading() {
        print("Hide Loading")
    }
}
