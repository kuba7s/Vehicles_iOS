//
//  VehicleCell.swift
//  Vehicles
//
//  Created by Alexandre Carvalho on 11/06/2024.
//

import Foundation
import UIKit

class VehicleCell: UITableViewCell {

    // MARK: - UI Elements

    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .themeColor(.white)
        return view
    }()

    private lazy var brandImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var labelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 17)
        label.numberOfLines = 2
        label.textColor = .themeColor(.black)
        return label
    }()

    private lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = .themeColor(.primary)
        return label
    }()

    private lazy var daysLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()

    private lazy var favoriteStatusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.setImage(UIImage(systemName: "heart.fill"), for: .selected)
        button.tintColor = .red
        button.addAction(onFavoriteButtonTapped(), for: .touchUpInside)
        return button
    }()

    // MARK: - Properties

    static var reuseIdentifier: String {
        String(describing: self)
    }
    
    private var didTapFavoriteButton: (() -> Void)?
    private var shouldShowFavoriteButton: Bool = true

    // MARK: - Life cycle methods

    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        alpha = highlighted ? 0.5 : 1
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    // MARK: - Public methods

    func setup(model: VehicleViewModel,
               shouldShowFavoriteButton: Bool = true,
               didTapFavoriteButton: @escaping () -> Void) {
        self.didTapFavoriteButton = didTapFavoriteButton
        self.shouldShowFavoriteButton = shouldShowFavoriteButton
        
        brandImageView.image = model.brandLogo

        titleLabel.text = "\(model.make) \(model.model)"
        amountLabel.text = model.startingBid

        if let timeUntilBidStarts = model.timeUntilBidStarts {
            daysLabel.text = timeUntilBidStarts
        }
        
        favoriteStatusButton.isSelected = model.favourite
        favoriteStatusButton.isHidden = !shouldShowFavoriteButton
    }

    // MARK: - Private methods

    private func commonInit() {
        addSubviews()
        setupConstraints()
        setupColorsAndStyle()
    }

    private func addSubviews() {
        contentView.addSubview(containerView)
        containerView.addSubview(brandImageView)
        containerView.addSubview(labelsStackView)
        labelsStackView.addArrangedSubview(titleLabel)
        labelsStackView.addArrangedSubview(amountLabel)
        labelsStackView.addArrangedSubview(daysLabel)
        containerView.addSubview(favoriteStatusButton)
    }

    private func setupConstraints() {
        containerView.topToSuperview(offset: 8)
        containerView.leadingToSuperview(offset: 16)
        containerView.trailingToSuperview(offset: 16)
        containerView.bottomToSuperview(offset: -8)

        brandImageView.leadingToSuperview(offset: 8)
        brandImageView.size(CGSize(width: 48, height: 48))
        brandImageView.centerYToSuperview()

        labelsStackView.topToSuperview(offset: 8)
        labelsStackView.leadingToTrailing(of: brandImageView, offset: 8)
        labelsStackView.trailingToLeading(of: favoriteStatusButton)
        labelsStackView.bottomToSuperview(offset: -8)

        favoriteStatusButton.trailingToSuperview(offset: 16)
        favoriteStatusButton.centerYToSuperview()
        favoriteStatusButton.size(CGSize(width: 32, height: 32))
    }

    private func setupColorsAndStyle() {
        backgroundColor = .clear
        selectionStyle = .none
        containerView.applyDefaultCornerRadius()
        containerView.applyDefaultShadow()
    }
    
    // MARK: - Actions
    
    private func onFavoriteButtonTapped() -> UIAction {
        return UIAction { _ in
            self.favoriteStatusButton.isSelected = !self.favoriteStatusButton.isSelected
            
            if let didTapFavoriteButton = self.didTapFavoriteButton {
                didTapFavoriteButton()
            }
        }
    }
}
