//
//  FavoriteDelegate.swift
//  Vehicles
//
//  Created by Alexandre Carvalho on 12/06/2024.
//

import Foundation
import UIKit

class FavoriteDelegate: NSObject, UITableViewDelegate {
    weak var viewController: FavoritesViewController?
    
    func setup(_ viewController: FavoritesViewController) {
        self.viewController = viewController
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewController = viewController else { return }
        let selectedVehicle = viewController.vehicles[indexPath.row]
//        viewController.showVehicleDetails(for: selectedVehicle)
    }
}
