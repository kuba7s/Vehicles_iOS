//
//  VehicleDetailCell.swift
//  Vehicles
//
//  Created by Alexandre Carvalho on 12/06/2024.
//

import UIKit

class VehicleDetailCell: UITableViewCell {
    
    static let reuseIdentifier = "VehicleDetailCell"
    
    private let titleLabel = UILabel()
    private let valueLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.font = .boldSystemFont(ofSize: 16)
        valueLabel.font = .systemFont(ofSize: 16)
        valueLabel.textAlignment = .right

        contentView.addSubview(titleLabel)
        contentView.addSubview(valueLabel)
        
        titleLabel.leadingToSuperview(offset: 16)
        titleLabel.centerYToSuperview()

        valueLabel.trailingToSuperview(offset: 16)
        valueLabel.centerYToSuperview()

        titleLabel.trailingToLeading(of: valueLabel, offset: -8)
    }
    
    func configure(withTitle title: String, value: String) {
        titleLabel.text = title
        valueLabel.text = value
    }
}
