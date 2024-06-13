//
//  VehicleListViewController.swift
//  Vehicles
//
//  Created by Alexandre Carvalho on 11/06/2024.
//

import UIKit

protocol VehicleFavoritingDelegate: AnyObject {
    func setList(with vehicles: [Vehicle])
    func didSelectFavorite(vehicle: Vehicle)
}

class VehicleListViewController: UIViewController {

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

    // MARK: - Properties

    private let vehicleService: VehicleService
    private let dataSource: VehicleDataSource
    private let delegate: VehicleDelegate

    var vehicles: [Vehicle] = []
    var originalVehiclesList: [Vehicle] = []

    weak var favoritingDelegate: VehicleFavoritingDelegate?

    init(vehicleService: VehicleService,
         dataSource: VehicleDataSource,
         delegate: VehicleDelegate) {
        self.vehicleService = vehicleService
        self.dataSource = dataSource
        self.delegate = delegate

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupConstraints()
        setupNavigationBar()

        self.delegate.setup(self)

        self.dataSource.onFavoriteButtonTapped = { [weak self] vehicle in
            self?.updateFavoriteStatus(for: vehicle)
        }

        vehicleService.fetchVehicles { [weak self] vehicles in
            self?.originalVehiclesList = vehicles
            self?.updateDataSource(with: vehicles)
            self?.favoritingDelegate?.setList(with: vehicles.filter { $0.favourite })
        }
    }

    func updateDataSource(with vehicles: [Vehicle]) {
        dataSource.update(with: vehicles)
        self.vehicles = vehicles
        tableView.reloadData()
    }

    private func setupUI() {
        view.addSubview(tableView)
        view.backgroundColor = .themeColor(.background)
    }

    private func setupConstraints() {
        tableView.edgesToSuperview()
    }

    private func setupNavigationBar() {
        let sortButton = UIBarButtonItem(image: UIImage(systemName: "slider.horizontal.3"), style: .plain, target: self, action: #selector(onSortingButtonTapped))
        navigationItem.rightBarButtonItems = [sortButton, getSearchMenuButton()]

        navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func showFilterActionSheet() {
        let alert = UIAlertController(title: "Sort by", message: nil, preferredStyle: .actionSheet)

        alert.addAction(UIAlertAction(title: "Make", style: .default, handler: { _ in
            self.updateDataSource(with: self.vehicles.sorted { $0.make.rawValue < $1.make.rawValue })
        }))

        alert.addAction(UIAlertAction(title: "Starting Bid", style: .default, handler: { _ in
            self.updateDataSource(with: self.vehicles.sorted { $0.startingBid > $1.startingBid })
        }))

        alert.addAction(UIAlertAction(title: "Mileage", style: .default, handler: { _ in
            self.updateDataSource(with: self.vehicles.sorted { $0.mileage > $1.mileage }) }))

        alert.addAction(UIAlertAction(title: "Auction Date", style: .default, handler: { _ in
            self.updateDataSource(with: self.vehicles.sorted { $0.auctionDateTime < $1.auctionDateTime })
        }))

        alert.addAction(UIAlertAction(title: "Reset Filters", style: .destructive, handler: { _ in
            self.updateDataSource(with: self.originalVehiclesList)
        }))

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        /// for  iPad Support
        alert.popoverPresentationController?.sourceView = self.view

        present(alert, animated: true)
    }

    private func getSearchMenuButton() -> UIBarButtonItem {
        let makeAction = UIAction(title: "Make") { _ in
            let itemsList = self.originalVehiclesList.map ({ $0.make.rawValue }).unique()
            let alertVC = AlertViewController(self,
                                              itemsList: itemsList,
                                              selectedItem: "") { newValue in
                if newValue.isEmpty {
                    self.updateDataSource(with: self.originalVehiclesList)
                } else {
                    self.updateDataSource(with: self.originalVehiclesList.filter { $0.make.rawValue == newValue })
                }

            }
            alertVC.show()

        }
        let modelAction = UIAction(title: "Model") { _ in
            let itemsList = self.originalVehiclesList.map ({ $0.model }).unique()
            let alertVC = AlertViewController(self,
                                              itemsList: itemsList,
                                              selectedItem: "") { newValue in
                if newValue.isEmpty {
                    self.updateDataSource(with: self.originalVehiclesList)
                } else {
                    self.updateDataSource(with: self.originalVehiclesList.filter { $0.model == newValue })
                }
            }
            alertVC.show()

        }
        let bidRangeAction = UIAction(title: "Starting Bid range") { _ in
            self.showStartingBidAlert()
        }
        let menu = UIMenu(title: "", children: [makeAction, modelAction, bidRangeAction])
        return UIBarButtonItem(title: nil, image: UIImage(systemName: "magnifyingglass"), primaryAction: nil, menu: menu)
    }

    private func showStartingBidAlert() {
        // Create the alert controller
        let alertController = UIAlertController(title: "Starting Bid Range", message: "Enter the minimum and maximum values", preferredStyle: .alert)

        // Add the first text field
        alertController.addTextField { textField in
            if let minimumValue = self.originalVehiclesList.map({ $0.startingBid }).min() {
                textField.placeholder = "Minimum value: \(minimumValue)"
            }
            textField.keyboardType = .numberPad
        }

        // Add the second text field
        alertController.addTextField { textField in
            if let maximumValue = self.originalVehiclesList.map({ $0.startingBid }).max() {
                textField.placeholder = "Maximum value: \(maximumValue)"
            }
            textField.keyboardType = .numberPad
        }

        // Add the OK action
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            // Access the text fields
            if let textFields = alertController.textFields, textFields.count == 2 {
                let firstTextField = textFields[0]
                let secondTextField = textFields[1]

                // Get the text from the text fields
                if let minimumRange = Int(firstTextField.text ?? ""),
                    let maximumRange = Int(secondTextField.text ?? "") {
                    let listFiltered = self.originalVehiclesList.filter { $0.startingBid > minimumRange && $0.startingBid < maximumRange }
                    self.updateDataSource(with: listFiltered)
                }
            }
        }

        // Add the Cancel action
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        // Add the actions to the alert controller
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)

        // Present the alert controller
        present(alertController, animated: true, completion: nil)
    }

    // MARK: - Actions

    @objc private func onSortingButtonTapped() {
        showFilterActionSheet()
    }
}

extension VehicleListViewController {
    func showVehicleDetails(for vehicle: Vehicle) {

        let viewController = VehicleDetailViewController(vehicle: vehicle)
        navigationController?.pushViewController(viewController, animated: true)
    }

    func updateFavoriteStatus(for vehicle: Vehicle) {
        for (index, item) in vehicles.enumerated() {

            if item == vehicle {
                vehicles[index].favourite.toggle()
                updateDataSource(with: vehicles)
            }
        }

        favoritingDelegate?.didSelectFavorite(vehicle: vehicle)
    }
}
