//
//  MoviesViewController.swift
//  MandiriMovie
//
//  Created by ITUMAC02 on 03/06/26.
//

import UIKit
import SnapKit

final class MoviesViewController: UIViewController {
    var presenter: MoviesViewToPresenterProtocol?
    
    private var movies: [Movie] = []
    private var isLoadingMore = false
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemGroupedBackground
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 140
        tableView.register(MovieCell.self, forCellReuseIdentifier: MovieCell.identifier)
        return tableView
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let act = UIActivityIndicatorView(style: .large)
        act.hidesWhenStopped = true
        return act
    }()

    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.viewDidLoad()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = false
        view.addSubview(tableView)
        view.addSubview(activityIndicator)

        tableView.snp.makeConstraints { $0.edges.equalToSuperview() }
        activityIndicator.snp.makeConstraints { $0.center.equalToSuperview() }

        tableView.delegate   = self
        tableView.dataSource = self
        tableView.refreshControl = refreshControl
    }
    
    @objc private func handleRefresh() {
        movies.removeAll()
        tableView.reloadData()
        presenter?.didPullToRefresh()
    }
}

// MARK: - UITableViewDataSource
extension MoviesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.identifier, for: indexPath) as! MovieCell
        cell.configure(with: movies[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate
extension MoviesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectMovie(movies[indexPath.row])
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard  indexPath.row == movies.count - 3 else { return }
        isLoadingMore = true
        presenter?.loadNextPage()
    }
}

extension MoviesViewController: MoviesPresenterToViewProtocol {
    func showMovies(_ movies: [Movie], replace: Bool) {
        isLoadingMore = false
        if replace {
            refreshControl.endRefreshing()
            self.movies = movies
            tableView.reloadData()
        } else {
            let startIndex = self.movies.count
            self.movies.append(contentsOf: movies)
            let indexPaths = (startIndex..<self.movies.count).map { IndexPath(row: $0, section: 0) }
            tableView.insertRows(at: indexPaths, with: .automatic)
        }
    }
    
    func showError(_ message: String) {
        print(#function)
    }
    
    func showLoading() {
        print(#function)
    }
    
    func hideLoading() {
        print(#function)
    }
    
}
