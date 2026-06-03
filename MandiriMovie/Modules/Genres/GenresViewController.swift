//
//  GenresViewController.swift
//  MandiriMovie
//
//  Created by ITUMAC02 on 03/06/26.
//

import UIKit
import SnapKit

final class GenresViewController: UIViewController {
    
    var presenter: GenresViewToPresenterProtocol?
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 12
        layout.minimumLineSpacing = 12
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        let coll = UICollectionView(frame: .zero, collectionViewLayout: layout)
        coll.backgroundColor = .systemGroupedBackground
        coll.register(GenreCell.self, forCellWithReuseIdentifier: GenreCell.identifier)
        return coll
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let act = UIActivityIndicatorView(style: .large)
        act.color = .label
        act.hidesWhenStopped = true
        return act
    }()
    
    private var genres: [Genre] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.viewDidLoad()
    }
    
    private func setupUI() {
        title = "Movie Genres"
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.addSubview(collectionView)
        view.addSubview(activityIndicator)
        
        collectionView.snp.makeConstraints { $0.edges.equalToSuperview() }
        activityIndicator.snp.makeConstraints { $0.edges.equalToSuperview() }
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func cellSize() -> CGSize {
        let padding: CGFloat = 16 * 2 + 12
        let width = (view.frame.width - padding) / 2
        return CGSize(width: width, height: 80)
    }
}

//MARK: UICollectionViewDataSource
extension GenresViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return genres.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenreCell.identifier, for: indexPath) as! GenreCell
        
        cell.configure(with: genres[indexPath.item])
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension GenresViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.didSelectGenre(genres[indexPath.item])
    }
}

//MARK: UICollectionViewDelegateFlowLayout
extension GenresViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return cellSize()
    }
}

//MARK: - GenresPresenterToViewProtocol
extension GenresViewController: GenresPresenterToViewProtocol {
    func showGenres(_ genres: [Genre]) {
        self.genres = genres
        collectionView.reloadData()
    }
    
    func showError(_ message: String) {
        print("show Error")
    }
    
    func showLoading() {
        activityIndicator.startAnimating()
        
    }
    
    func hideLoading() {
        activityIndicator.stopAnimating()
    }
}
