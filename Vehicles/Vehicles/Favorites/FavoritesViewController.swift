//
//  FavoritesViewController.swift
//  Vehicles
//
//  Created by Alexandre Carvalho on 12/06/2024.
//

import Foundation
import UIKit

class FavoritesViewController: UIViewController {

    // MARK: - UI Components

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(VehicleCell.self, forCellReuseIdentifier: VehicleCell.reuseIdentifier)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.dataSource = dataSource
        tableView.delegate = delegate
        return tableView
    }()

    var favoriteVehicles: [Vehicle] = []

    private let dataSource: FavoriteDataSource
    private let delegate: FavoriteDelegate

    var vehicles: [Vehicle] = []

    weak var favoritingDelegate: VehicleFavoritingDelegate?

    init(dataSource: FavoriteDataSource,
         delegate: FavoriteDelegate) {
        self.dataSource = dataSource
        self.delegate = delegate

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        setupUI()
        setupConstraints()

        tableView.reloadData()
    }

    private func setupUI() {
        view.addSubview(tableView)
        view.backgroundColor = .themeColor(.background)
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func setupConstraints() {
        tableView.edgesToSuperview()
    }

    private func updateDataSource(with vehicles: [Vehicle]) {
        dataSource.update(with: vehicles)
        self.vehicles = vehicles
        tableView.reloadData()
    }
}

// MARK: - VehicleFavoritingDelegate
extension FavoritesViewController: VehicleFavoritingDelegate {
    func setList(with vehicles: [Vehicle]) {
        updateDataSource(with: vehicles)
    }

    func didSelectFavorite(vehicle: Vehicle) {
        if vehicle.favourite == false {
            vehicles.insert(vehicle, at: 0)
        } else {
            for (index, item) in vehicles.enumerated() {

                if item == vehicle, vehicle.favourite == true {
                    vehicles.remove(at: index)
                }

            }
        }
        updateDataSource(with: vehicles)
    }
}
