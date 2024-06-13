//
//  VehicleDetailDataSource.swift
//  Vehicles
//
//  Created by Alexandre Carvalho on 13/06/2024.
//

import UIKit

class VehicleDetailDataSource: NSObject, UITableViewDataSource {
    
    private var vehicle: Vehicle

    init(vehicle: Vehicle) {
        self.vehicle = vehicle
        super.init()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 7
        case 1:
            return 7
        case 2:
            return 3
        case 3:
            return vehicle.details.equipment.count
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Vehicle Information"
        case 1:
            return "Specification"
        case 2:
            return "Ownership"
        case 3:
            return "Equipment"
        default:
            return nil
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: VehicleDetailCell.reuseIdentifier, for: indexPath) as? VehicleDetailCell else {
            fatalError("Unexpected cell type")
        }
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                cell.configure(withTitle: "Engine Size:", value: vehicle.engineSize)
            case 1:
                cell.configure(withTitle: "Fuel Type:", value: vehicle.fuel)
            case 2:
                cell.configure(withTitle: "Year:", value: "\(vehicle.year)")
            case 3:
                cell.configure(withTitle: "Mileage:", value: "\(vehicle.mileage)")
            case 4:
                cell.configure(withTitle: "Auction Date:", value: vehicle.auctionDateTime)
            case 5:
                cell.configure(withTitle: "Starting Bid:", value: "\(vehicle.startingBid)")
            case 6:
                cell.configure(withTitle: "Favourite:", value: vehicle.favourite ? "Yes" : "No")
            default:
                break
            }
        case 1:
            let specification = vehicle.details.specification
            switch indexPath.row {
            case 0:
                cell.configure(withTitle: "Vehicle Type:", value: specification.vehicleType.rawValue)
            case 1:
                cell.configure(withTitle: "Colour:", value: specification.colour.rawValue)
            case 2:
                cell.configure(withTitle: "Fuel:", value: specification.fuel.rawValue)
            case 3:
                cell.configure(withTitle: "Transmission:", value: specification.transmission.rawValue)
            case 4:
                cell.configure(withTitle: "Number Of Doors:", value: "\(specification.numberOfDoors)")
            case 5:
                cell.configure(withTitle: "CO2 Emissions:", value: specification.co2Emissions.rawValue)
            case 6:
                cell.configure(withTitle: "NOX Emissions:", value: "\(specification.noxEmissions)")
            default:
                break
            }
        case 2:
            let ownership = vehicle.details.ownership
            switch indexPath.row {
            case 0:
                cell.configure(withTitle: "Logbook:", value: ownership.logBook.rawValue)
            case 1:
                cell.configure(withTitle: "Number Of Owners:", value: "\(ownership.numberOfOwners)")
            case 2:
                cell.configure(withTitle: "Date Of Registration:", value: ownership.dateOfRegistration.rawValue)
            default:
                break
            }
        case 3:
            let equipment = vehicle.details.equipment[indexPath.row]
            cell.configure(withTitle: "", value: equipment.rawValue)
        default:
            break
        }

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}
