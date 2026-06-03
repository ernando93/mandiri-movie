//
//  MovieCell.swift
//  MandiriMovie
//
//  Created by ITUMAC02 on 03/06/26.
//

import UIKit
import SnapKit
import Kingfisher

final class MovieCell: UITableViewCell {
    static let identifier = "MovieCell"
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 2
        label.textColor = .black
        return label
    }()
    
    private let ratingContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemYellow.withAlphaComponent(0.2)
        view.layer.cornerRadius = 6
        return view
    }()

    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 13)
        label.textColor = .systemOrange
        return label
    }()

    private let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .secondaryLabel
        return label
    }()

    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .secondaryLabel
        label.numberOfLines = 2
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) { fatalError() }

    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.kf.cancelDownloadTask()
        posterImageView.image = nil
    }

    private func setupUI() {
        selectionStyle = .none
        let stack = UIStackView(arrangedSubviews: [titleLabel, ratingContainerView, releaseDateLabel, overviewLabel])
        stack.axis = .vertical
        stack.spacing = 6
        stack.alignment = .leading

        ratingContainerView.addSubview(ratingLabel)
        ratingLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 3, left: 6, bottom: 3, right: 6))
        }

        contentView.addSubview(posterImageView)
        contentView.addSubview(stack)

        posterImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.top.equalToSuperview().offset(12)
            $0.bottom.lessThanOrEqualToSuperview().offset(-12)
            $0.width.equalTo(80)
            $0.height.equalTo(115)
        }

        stack.snp.makeConstraints {
            $0.leading.equalTo(posterImageView.snp.trailing).offset(12)
            $0.trailing.equalToSuperview().offset(-16)
            $0.top.equalTo(posterImageView.snp.top)
            $0.bottom.lessThanOrEqualToSuperview().offset(-12)
        }
    }

    // MARK: - Configure
    func configure(with movie: Movie) {
        titleLabel.text = movie.title
        ratingLabel.text = "⭐ \(movie.formattedRating)"
        releaseDateLabel.text = "📅 \(movie.releaseDate)"
        overviewLabel.text = movie.overview
        
        posterImageView.kf.setImage(with: movie.posterURL, placeholder: UIImage(systemName: "film"))
    }
}

