//
//  VehicleDataSource.swift
//  Vehicles
//
//  Created by Alexandre Carvalho on 11/06/2024.
//

import UIKit

class VehicleDataSource: NSObject, UITableViewDataSource {

    var viewModels: [VehicleViewModel] = []
    private var vehiclesList: [Vehicle] = []
    
    var onFavoriteButtonTapped: ((Vehicle) -> Void)?

    func update(with vehicles: [Vehicle]) {
        self.vehiclesList = vehicles
        self.viewModels = vehicles.map { VehicleViewModel(vehicle: $0) }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: VehicleCell.reuseIdentifier, for: indexPath) as? VehicleCell {
            let viewModel = viewModels[indexPath.row]
            let vehicle = vehiclesList[indexPath.row]
            cell.setup(model: viewModel) {
                if let onFavoriteButtonTapped = self.onFavoriteButtonTapped {
                    onFavoriteButtonTapped(vehicle)
                }
            }
            return cell
        }
        fatalError("No VehicleCell dequeued")
    }
}
