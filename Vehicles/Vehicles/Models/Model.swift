//
//  Model.swift
//  Vehicles
//
//  Created by Alexandre Carvalho on 11/06/2024.
//

import Foundation
import UIKit

struct Vehicle: Equatable, Codable {
    let make: Make
    let model: String
    let engineSize: String
    let fuel: String
    let year, mileage: Int
    let auctionDateTime: String
    let startingBid: Int
    var favourite: Bool
    let details: Details

    static func == (lhs: Vehicle, rhs: Vehicle) -> Bool {
        return lhs.make == rhs.make &&
            lhs.model == rhs.model &&
            lhs.engineSize == rhs.engineSize &&
            lhs.fuel == rhs.fuel &&
            lhs.year == rhs.year &&
            lhs.mileage == rhs.mileage &&
            lhs.auctionDateTime == rhs.auctionDateTime &&
            lhs.startingBid == rhs.startingBid &&
            lhs.details == rhs.details
    }
}

// MARK: - Details
struct Details: Codable, Equatable {
    let specification: Specification
    let ownership: Ownership
    let equipment: [Equipment]

    static func == (lhs: Details, rhs: Details) -> Bool {
        return lhs.specification == rhs.specification &&
            lhs.ownership == rhs.ownership &&
            lhs.equipment == rhs.equipment
    }
}

enum Equipment: String, Codable, Equatable {
    case airConditioning = "Air Conditioning"
    case engineModsUpgrades = "Engine Mods/Upgrades"
    case modifdAddedBodyParts = "Modifd/Added Body Parts"
    case navigationHDD = "Navigation HDD"
    case photocopyOfV5Present = "Photocopy of V5 Present"
    case the17AlloyWheels = "17 Alloy Wheels"
    case tyreInflationKit = "Tyre Inflation Kit"
}

// MARK: - Ownership
struct Ownership: Codable, Equatable {
    let logBook: LogBook
    let numberOfOwners: Int
    let dateOfRegistration: DateOfRegistration

    static func == (lhs: Ownership, rhs: Ownership) -> Bool {
        return lhs.logBook == rhs.logBook &&
            lhs.numberOfOwners == rhs.numberOfOwners &&
            lhs.dateOfRegistration == rhs.dateOfRegistration
    }
}

enum DateOfRegistration: String, Codable, Equatable {
    case the20150331090000 = "2015/03/31 09:00:00"
}

enum LogBook: String, Codable, Equatable {
    case present = "Present"
}

// MARK: - Specification
struct Specification: Codable, Equatable {
    let vehicleType: VehicleType
    let colour: Colour
    let fuel: Fuel
    let transmission: Transmission
    let numberOfDoors: Int
    let co2Emissions: Co2Emissions
    let noxEmissions, numberOfKeys: Int

    static func == (lhs: Specification, rhs: Specification) -> Bool {
        return lhs.vehicleType == rhs.vehicleType &&
            lhs.colour == rhs.colour &&
            lhs.fuel == rhs.fuel &&
            lhs.transmission == rhs.transmission &&
            lhs.numberOfDoors == rhs.numberOfDoors &&
            lhs.co2Emissions == rhs.co2Emissions &&
            lhs.noxEmissions == rhs.noxEmissions &&
            lhs.numberOfKeys == rhs.numberOfKeys
    }
}

enum Co2Emissions: String, Codable, Equatable {
    case the139GKM = "139 g/km"
}

enum Colour: String, Codable, Equatable {
    case red = "RED"
}

enum Fuel: String, Codable, Equatable {
    case diesel = "diesel"
    case petrol = "petrol"
}

enum Transmission: String, Codable, Equatable {
    case manual = "Manual"
}

enum VehicleType: String, Codable, Equatable {
    case car = "Car"
}

enum EngineSize: String, Codable, Equatable {
    case the16L = "1.6L"
    case the18L = "1.8L"
}

enum Make: String, Codable, Equatable, CaseIterable {
    case audi = "Audi"
    case bmw = "BMW"
    case citroen = "Citroen"
    case ford = "Ford"
    case mercedesBenz = "Mercedes-Benz"
    case toyota = "Toyota"
    case volkswagen = "Volkswagen"
    case volvo = "Volvo"

    var image: UIImage? {
        switch self {
        case .audi:
            return UIImage(named: "AudiLogo")
        case .bmw:
            return UIImage(named: "BmwLogo")
        case .citroen:
            return UIImage(named: "CitroenLogo")
        case .ford:
            return UIImage(named: "FordLogo")
        case .mercedesBenz:
            return UIImage(named: "MercedesLogo")
        case .toyota:
            return UIImage(named: "ToyotaLogo")
        case .volkswagen:
            return UIImage(named: "VolkswagenLogo")
        case .volvo:
            return UIImage(named: "VolvoLogo")
        }
    }
}

enum Model: String, Codable, Equatable {
    case a3 = "A3"
    case a4 = "A4"
    case aClassHatchback = "A-Class Hatchback"
    case aClassSaloon = "A-Class Saloon"
    case bClass = "B-Class"
    case c30 = "C30"
    case c3Aircross = "C3 Aircross"
    case c3Origin = "C3 Origin"
    case c40 = "C40"
    case c5Aircross = "C5 Aircross"
    case cHr = "C-HR"
    case corolla = "Corolla"
    case fiesta = "Fiesta"
    case focus = "Focus"
    case focusCMax = "Focus C-Max"
    case golf = "Golf"
    case passat = "Passat"
    case polo = "Polo"
    case the1Series = "1 Series"
    case the3Series = "3 Series"
    case v40 = "V40"
}
