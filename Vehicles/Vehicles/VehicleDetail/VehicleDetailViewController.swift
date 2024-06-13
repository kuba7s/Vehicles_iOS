//
//  VehicleDetailViewController.swift
//  Vehicles
//
//  Created by Alexandre Carvalho on 12/06/2024.
//

import UIKit
import TinyConstraints

class VehicleDetailViewController: UIViewController {

    // MARK: - UI Components

    private lazy var vehicleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        return imageView
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(VehicleDetailCell.self, forCellReuseIdentifier: VehicleDetailCell.reuseIdentifier)
        tableView.allowsSelection = false
        tableView.backgroundColor = .clear
        return tableView
    }()

    // MARK: - Properties

    private var dataSource: VehicleDetailDataSource
    private var vehicle: Vehicle

    init(vehicle: Vehicle) {
        self.vehicle = vehicle
        self.dataSource = VehicleDetailDataSource(vehicle: vehicle)
        super.init(nibName: nil, bundle: nil)
        self.title = "\(vehicle.make) \(vehicle.model)"
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = dataSource
        setupUI()
    }

    private func setupUI() {
        vehicleImageView.image = vehicle.make.image

        view.backgroundColor = .themeColor(.background)
        view.addSubview(vehicleImageView)
        view.addSubview(tableView)

        vehicleImageView.topToSuperview(usingSafeArea: true)
        vehicleImageView.leadingToSuperview()
        vehicleImageView.trailingToSuperview()
        vehicleImageView.height(120)

        tableView.topToBottom(of: vehicleImageView)
        tableView.leadingToSuperview()
        tableView.trailingToSuperview()
        tableView.bottomToSuperview(usingSafeArea: true)
    }
}
