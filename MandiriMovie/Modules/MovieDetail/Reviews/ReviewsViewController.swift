//
//  ReviewsViewController.swift
//  MandiriMovie
//
//  Created by ITUMAC02 on 05/06/26.
//

import UIKit
import SnapKit

final class ReviewsViewController: UIViewController {
    var presenter: ReviewsViewToPresenterProtocol?
    
    private var reviews: [Review] = []
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 120
        tableView.register(ReviewCell.self, forCellReuseIdentifier: ReviewCell.identifier)
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
        view.backgroundColor = .white
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
        reviews.removeAll()
        tableView.reloadData()
        presenter?.didPullToRefresh()
    }
}

// MARK: - UITableViewDataSource
extension ReviewsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReviewCell.identifier, for: indexPath) as! ReviewCell
        cell.configure(with: reviews[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ReviewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard  indexPath.row == reviews.count - 3 else { return }
        presenter?.loadNextPage()
    }
}

extension ReviewsViewController: ReviewsPresenterToViewProtocol {
    func showReviews(_ reviews: [Review], replace: Bool) {
        if replace {
            refreshControl.endRefreshing()
            self.reviews = reviews
            tableView.reloadData()
        } else {
            let startIndex = self.reviews.count
            self.reviews.append(contentsOf: reviews)
            let indexPaths = (startIndex..<self.reviews.count).map { IndexPath(row: $0, section: 0) }
            tableView.insertRows(at: indexPaths, with: .automatic)
        }
    }
    
    func showError(_ message: String) {
        print(#function)
    }
    
    func showLoading() {
        activityIndicator.startAnimating()
    }
    
    func hideLoading() {
        activityIndicator.stopAnimating()
    }
}
