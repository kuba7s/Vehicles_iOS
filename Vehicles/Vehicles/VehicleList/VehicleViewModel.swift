//
//  VehicleViewModel.swift
//  Vehicles
//
//  Created by Alexandre Carvalho on 11/06/2024.
//

import Foundation
import UIKit

class VehicleViewModel {
    
    private let vehicle: Vehicle

    var make: String {
        return vehicle.make.rawValue
    }
    
    var brandLogo: UIImage {
        return vehicle.make.image ?? .checkmark
    }

    var model: String {
        return vehicle.model
    }

    var engineSize: String {
        return vehicle.engineSize
    }

    var fuelType: String {
        return vehicle.fuel
    }

    var year: String {
        return "\(vehicle.year)"
    }

    var mileage: String {
        return "\(vehicle.mileage) km"
    }

    var auctionDateTime: String {
        return vehicle.auctionDateTime
    }

    var startingBid: String {
        return "$ \(vehicle.startingBid)"
    }

    var favourite: Bool {
        return vehicle.favourite
    }
    
    var timeUntilBidStarts: String? {
        guard let auctionDate = auctionDateTime.mapToDate() else { return nil }
        let diffComponents = Calendar.current.dateComponents([.day, .hour],
                                                             from: Date(),
                                                             to: auctionDate)
        if let days = diffComponents.day, let hours = diffComponents.hour {
            return "\(days) day(s), \(hours) hour(s)"
        }
        return nil
    }

    init(vehicle: Vehicle) {
        self.vehicle = vehicle
    }
}
