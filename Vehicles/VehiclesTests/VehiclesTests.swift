//
//  VehiclesTests.swift
//  VehiclesTests
//
//  Created by Alexandre Carvalho on 07/06/2024.
//

import XCTest
@testable import Vehicles

final class VehicleTests: XCTestCase {

    func testVehicleInitialization() throws {
        // Given
        let vehicleDetails = Details(
            specification: Specification(
                vehicleType: .car,
                colour: .red,
                fuel: .diesel,
                transmission: .manual,
                numberOfDoors: 3,
                co2Emissions: .the139GKM,
                noxEmissions: 230,
                numberOfKeys: 2
            ),
            ownership: Ownership(
                logBook: .present,
                numberOfOwners: 8,
                dateOfRegistration: .the20150331090000
            ),
            equipment: [
                .airConditioning,
                .engineModsUpgrades,
                .modifdAddedBodyParts,
                .navigationHDD,
                .photocopyOfV5Present,
                .the17AlloyWheels,
                .tyreInflationKit
            ]
        )

        let vehicle1 = Vehicle(
            make: .toyota,
            model: "C-HR",
            engineSize: "the18L",
            fuel: "diesel",
            year: 2022,
            mileage: 743,
            auctionDateTime: "2024/06/15 09:00:00",
            startingBid: 17000,
            favourite: true,
            details: vehicleDetails
        )

        let vehicle2 = Vehicle(
            make: .toyota,
            model: "C-HR",
            engineSize: "the18L",
            fuel: "diesel",
            year: 2022,
            mileage: 743,
            auctionDateTime: "2024/06/15 09:00:00",
            startingBid: 17000,
            favourite: true,
            details: vehicleDetails
        )

        // When
        // Then
        XCTAssertEqual(vehicle1, vehicle2)
    }

    static var allTests = [
        ("testVehicleInitialization", testVehicleInitialization),
    ]
}

