//
//  ReviewCardView.swift
//  MandiriMovie
//
//  Created by ITUMAC02 on 04/06/26.
//

import UIKit
import SnapKit
import Kingfisher

final class ReviewCardView: UIView {

    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.backgroundColor = .systemGray5
        imageView.image = UIImage(systemName: "person.circle.fill")
        imageView.tintColor = .systemGray3
        return imageView
    }()

    private let authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .label
        return label
    }()

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .tertiaryLabel
        return label
    }()

    private let starsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        return label
    }()

    private let contentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .secondaryLabel
        label.numberOfLines = 3
        return label
    }()

    init(review: Review) {
        super.init(frame: .zero)
        setupUI()
        configure(with: review)
    }

    required init?(coder: NSCoder) { fatalError() }

    private func setupUI() {
        backgroundColor = .secondarySystemBackground
        layer.cornerRadius = 12
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.06
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 6

        addSubview(avatarImageView)
        addSubview(authorLabel)
        addSubview(dateLabel)
        addSubview(starsLabel)
        addSubview(contentLabel)

        avatarImageView.snp.makeConstraints {
            $0.leading.top.equalToSuperview().inset(12)
            $0.width.height.equalTo(40)
        }

        authorLabel.snp.makeConstraints {
            $0.leading.equalTo(avatarImageView.snp.trailing).offset(10)
            $0.top.equalTo(avatarImageView.snp.top).offset(2)
        }

        dateLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-12)
            $0.centerY.equalTo(authorLabel)
        }

        starsLabel.snp.makeConstraints {
            $0.leading.equalTo(authorLabel)
            $0.top.equalTo(authorLabel.snp.bottom).offset(3)
        }

        contentLabel.snp.makeConstraints {
            $0.top.equalTo(avatarImageView.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(12)
            $0.bottom.equalToSuperview().offset(-12)
        }
    }

    private func configure(with review: Review) {
        authorLabel.text = review.author
        dateLabel.text = review.formattedDate
        contentLabel.text = review.content

        if let url = review.authorDetails?.avatarURL {
            avatarImageView.kf.setImage(with: url, placeholder: UIImage(systemName: "person.circle.fill"))
        }

        if let rating = review.authorDetails?.rating {
            let filled = Int(rating / 2)
            let stars = String(repeating: "★", count: filled) + String(repeating: "☆", count: 5 - filled)
            let attr = NSMutableAttributedString(string: "\(stars) ", attributes: [
                .foregroundColor: UIColor.systemOrange,
                .font: UIFont.systemFont(ofSize: 13)
            ])
            attr.append(NSAttributedString(string: String(format: "%.1f", rating / 2), attributes: [
                .foregroundColor: UIColor.label,
                .font: UIFont.systemFont(ofSize: 13, weight: .semibold)
            ]))
            starsLabel.attributedText = attr
        } else {
            starsLabel.text = ""
        }
    }
}
