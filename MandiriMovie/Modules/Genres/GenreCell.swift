//
//  GenreCell.swift
//  MandiriMovie
//
//  Created by ITUMAC02 on 03/06/26.
//

import UIKit
import SnapKit

final class GenreCell: UICollectionViewCell {
    static let identifier = "GenreCell"
    
    private let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        return view
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(containerView)
        containerView.addSubview(nameLabel)
        containerView.snp.makeConstraints { $0.edges.equalToSuperview() }
        nameLabel.snp.makeConstraints { $0.edges.equalToSuperview().inset(12) }
    }
    
    //MARK: - Configure
    func configure(with genre: Genre) {
        nameLabel.text = "\(genre.emoji) \(genre.name)"
        containerView.backgroundColor = genre.color
    }
    
    override var isHighlighted: Bool {
        didSet { UIView.animate(withDuration: 0.1) { self.transform = self.isHighlighted ? .init(scaleX: 0.95, y: 0.95) : .identity } }
    }
}
