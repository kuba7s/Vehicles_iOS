//
//  VehicleDelegate.swift
//  Vehicles
//
//  Created by Alexandre Carvalho on 11/06/2024.
//

import Foundation
import UIKit

class VehicleDelegate: NSObject, UITableViewDelegate {
    weak var viewController: VehicleListViewController?
    
    func setup(_ viewController: VehicleListViewController) {
        self.viewController = viewController
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewController = viewController else { return }
        let selectedVehicle = viewController.vehicles[indexPath.row]
        viewController.showVehicleDetails(for: selectedVehicle)
    }
}
