//
//  ReviewCell.swift
//  MandiriMovie
//
//  Created by ITUMAC02 on 05/06/26.
//

import UIKit
import SnapKit
import Kingfisher

final class ReviewCell: UITableViewCell {
    static let identifier = "ReviewCell"
    
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) { fatalError() }

    override func prepareForReuse() {
        super.prepareForReuse()
        avatarImageView.kf.cancelDownloadTask()
        avatarImageView.image = nil
    }

    private func setupUI() {
        backgroundColor = .white
        selectionStyle = .none
        let viewContainer = UIView()
        viewContainer.backgroundColor = .secondarySystemBackground
        viewContainer.layer.cornerRadius = 12
        viewContainer.layer.shadowColor = UIColor.black.cgColor
        viewContainer.layer.shadowOpacity = 0.06
        viewContainer.layer.shadowOffset = CGSize(width: 0, height: 2)
        viewContainer.layer.shadowRadius = 6

        addSubview(viewContainer)
        
        viewContainer.addSubview(avatarImageView)
        viewContainer.addSubview(authorLabel)
        viewContainer.addSubview(dateLabel)
        viewContainer.addSubview(starsLabel)
        viewContainer.addSubview(contentLabel)

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
        
        viewContainer.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().offset(-8)
        }
    }

    // MARK: - Configure
    func configure(with review: Review) {
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
