//
//  MovieDetailViewController.swift
//  MandiriMovie
//
//  Created by ITUMAC02 on 04/06/26.
//

import UIKit
import SnapKit
import Kingfisher

final class MovieDetailViewController: UIViewController {
    var presenter: MovieDetailViewToPresenterProtocol?
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let backdropImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let backdropGradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.clear.cgColor, UIColor.systemBackground.cgColor]
        gradient.locations = [0.4, 1.0]
        return gradient
    }()
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.white.withAlphaComponent(0.2).cgColor
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.textColor = .label
        label.numberOfLines = 2
        return label
    }()

    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.textColor = .label
        return label
    }()

    private let metaLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .secondaryLabel
        label.numberOfLines = 2
        return label
    }()

    private let genreLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .secondaryLabel
        label.numberOfLines = 2
        return label
    }()

    private let statusBadge: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = .systemGreen
        label.layer.borderColor = UIColor.systemGreen.cgColor
        label.layer.borderWidth = 1
        label.layer.cornerRadius = 8
        label.clipsToBounds = true
        label.textAlignment = .center
        return label
    }()

    private let taglineLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.italicSystemFont(ofSize: 14)
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()

    private let watchTrailerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("  Watch Trailer", for: .normal)
        button.setImage(UIImage(systemName: "play.circle.fill"), for: .normal)
        button.tintColor = .white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.backgroundColor = UIColor(red: 0.85, green: 0.15, blue: 0.15, alpha: 1)
        button.layer.cornerRadius = 14
        return button
    }()

    private let overviewSectionLabel = MovieDetailViewController.makeSectionLabel("Overview")
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .label
        label.numberOfLines = 0
        return label
    }()

    private let reviewHeaderStack = UIStackView()
    private let reviewCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.textColor = .label
        return label
    }()
    private let seeAllButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("See All", for: .normal)
        button.setTitleColor(UIColor(red: 0.85, green: 0.15, blue: 0.15, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        return button
    }()

    private let reviewsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        return stackView
    }()

    private let activityIndicator: UIActivityIndicatorView = {
        let act = UIActivityIndicatorView(style: .large)
        act.hidesWhenStopped = true
        return act
    }()
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .white
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.buttonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.standardAppearance = appearance
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationBar()
        setupUI()
        presenter?.viewDidLoad()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        backdropGradient.frame = backdropImageView.bounds
    }
    
    private func setupUI() {
        view.addSubview(scrollView)
        view.addSubview(activityIndicator)
        scrollView.addSubview(contentView)
        scrollView.contentInsetAdjustmentBehavior = .never

        scrollView.snp.makeConstraints { $0.edges.equalToSuperview() }
        activityIndicator.snp.makeConstraints { $0.center.equalToSuperview() }
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }

        contentView.addSubview(backdropImageView)
        backdropImageView.layer.addSublayer(backdropGradient)
        backdropImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(260)
        }

        contentView.addSubview(posterImageView)
        posterImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(12)
            $0.top.equalTo(backdropImageView.snp.bottom).offset(-60)
            $0.width.equalTo(110)
            $0.height.equalTo(160)
        }

        let infoStack = UIStackView(arrangedSubviews: [titleLabel, ratingLabel, metaLabel, genreLabel, statusBadge])
        infoStack.axis = .vertical
        infoStack.spacing = 5
        infoStack.alignment = .leading

        contentView.addSubview(infoStack)
        infoStack.snp.makeConstraints {
            $0.leading.equalTo(posterImageView.snp.trailing).offset(12)
            $0.trailing.equalToSuperview().offset(-16)
            $0.centerY.equalTo(posterImageView.snp.centerY)
        }

        contentView.addSubview(taglineLabel)
        taglineLabel.snp.makeConstraints {
            $0.top.equalTo(posterImageView.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        contentView.addSubview(watchTrailerButton)
        watchTrailerButton.snp.makeConstraints {
            $0.top.equalTo(taglineLabel.snp.bottom).offset(14)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(52)
        }
        watchTrailerButton.addTarget(self, action: #selector(didTapWatchTrailer), for: .touchUpInside)

        contentView.addSubview(overviewSectionLabel)
        overviewSectionLabel.snp.makeConstraints {
            $0.top.equalTo(watchTrailerButton.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(16)
        }

        contentView.addSubview(overviewLabel)
        overviewLabel.snp.makeConstraints {
            $0.top.equalTo(overviewSectionLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        reviewHeaderStack.axis = .horizontal
        reviewHeaderStack.distribution = .equalSpacing
        reviewHeaderStack.addArrangedSubview(reviewCountLabel)
        reviewHeaderStack.addArrangedSubview(seeAllButton)
        seeAllButton.addTarget(self, action: #selector(didTapSeeAll), for: .touchUpInside)

        contentView.addSubview(reviewHeaderStack)
        reviewHeaderStack.snp.makeConstraints {
            $0.top.equalTo(overviewLabel.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        contentView.addSubview(reviewsStackView)
        reviewsStackView.snp.makeConstraints {
            $0.top.equalTo(reviewHeaderStack.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().offset(-32)
        }
    }
    
    private static func makeSectionLabel(_ text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.textColor = .label
        return label
    }
    
    private func makeRatingText(_ detail: MovieDetail) -> NSAttributedString {
        let star = NSAttributedString(string: "★ ", attributes: [
            .foregroundColor: UIColor.systemOrange,
            .font: UIFont.systemFont(ofSize: 15, weight: .bold)
        ])
        let rating = NSAttributedString(string: "\(detail.formattedRating)  •  \(detail.voteCount) votes", attributes: [
            .foregroundColor: UIColor.label,
            .font: UIFont.systemFont(ofSize: 14)
        ])
        let full = NSMutableAttributedString()
        full.append(star)
        full.append(rating)
        return full
    }
    
    @objc private func didTapWatchTrailer() {
        presenter?.didTapWatchTrailer()
    }

    @objc private func didTapSeeAll() {
        presenter?.didTapSeeAllReviews()
    }
}

extension MovieDetailViewController: MovieDetailPresenterToViewProtocol {
    func showMovieDetail(_ detail: MovieDetail) {
        title = detail.title
        titleLabel.text = detail.title
        ratingLabel.attributedText = self.makeRatingText(detail)
        metaLabel.text = "📅 \(detail.releaseDate)  •  🕐 \(detail.formattedRuntime)"
        genreLabel.text = detail.genreNames
        statusBadge.text = " \(detail.status)   "
        taglineLabel.text = detail.tagline ?? ""
        overviewLabel.text = detail.overview

        backdropImageView.kf.setImage(with: detail.backdropURL, placeholder: nil)
        posterImageView.kf.setImage(with: detail.posterURL, placeholder: UIImage(named: "poster-placeholder"))
    }
    
    func showReviews(_ reviews: [Review], totalReviews: Int) {
        seeAllButton.isHidden = totalReviews <= 5
        reviewCountLabel.text = "Reviews (\(totalReviews))"
        reviewsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        reviews.prefix(5).forEach { review in
            let card = ReviewCardView(review: review)
            reviewsStackView.addArrangedSubview(card)
        }
    }
    
    func showTrailer(_ trailerKey: String?) {
        watchTrailerButton.isHidden = trailerKey == nil
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
