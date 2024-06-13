//
//  VehicleDetailDataSourceTests.swift
//  VehiclesTests
//
//  Created by Alexandre Carvalho on 13/06/2024.
//

import XCTest
@testable import Vehicles

class VehicleDetailDataSourceTests: XCTestCase {

    var dataSource: VehicleDetailDataSource!
    var tableView: UITableView!

    override func setUp() {
        super.setUp()

        // Configuração inicial para cada teste
        let vehicle = Vehicle(
            make: .toyota,
            model: "C-HR",
            engineSize: "the18L",
            fuel: "diesel",
            year: 2022,
            mileage: 743,
            auctionDateTime: "2024/06/15 09:00:00",
            startingBid: 17000,
            favourite: true,
            details: Details(
                specification: Specification(
                    vehicleType: .car,
                    colour: .red,
                    fuel: .petrol,
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
                    .tyreInflationKit,
                    .photocopyOfV5Present,
                    .navigationHDD,
                    .the17AlloyWheels,
                    .engineModsUpgrades,
                    .modifdAddedBodyParts
                ]
            )
        )

        dataSource = VehicleDetailDataSource(vehicle: vehicle)
        tableView = UITableView()
        tableView.dataSource = dataSource
        tableView.register(VehicleDetailCell.self, forCellReuseIdentifier: VehicleDetailCell.reuseIdentifier)
    }

    override func tearDown() {
        dataSource = nil
        tableView = nil

        super.tearDown()
    }

    func testNumberOfSections() {
        // Given

        // When
        let numberOfSections = dataSource.numberOfSections(in: tableView)

        // Then
        XCTAssertEqual(numberOfSections, 4)
    }

    func testNumberOfRowsInSection() {
        // Given

        // When
        let numberOfRowsSection0 = dataSource.tableView(tableView, numberOfRowsInSection: 0)
        let numberOfRowsSection1 = dataSource.tableView(tableView, numberOfRowsInSection: 1)
        let numberOfRowsSection2 = dataSource.tableView(tableView, numberOfRowsInSection: 2)
        let numberOfRowsSection3 = dataSource.tableView(tableView, numberOfRowsInSection: 3)

        // Then
        XCTAssertEqual(numberOfRowsSection0, 7)
        XCTAssertEqual(numberOfRowsSection1, 7)
        XCTAssertEqual(numberOfRowsSection2, 3)
        XCTAssertEqual(numberOfRowsSection3, 7) // Verifique o número correto conforme seu exemplo
    }

    func testTitleForHeaderInSection() {
        // Given

        // When
        let titleSection0 = dataSource.tableView(tableView, titleForHeaderInSection: 0)
        let titleSection1 = dataSource.tableView(tableView, titleForHeaderInSection: 1)
        let titleSection2 = dataSource.tableView(tableView, titleForHeaderInSection: 2)
        let titleSection3 = dataSource.tableView(tableView, titleForHeaderInSection: 3)

        // Then
        XCTAssertEqual(titleSection0, "Vehicle Information")
        XCTAssertEqual(titleSection1, "Specification")
        XCTAssertEqual(titleSection2, "Ownership")
        XCTAssertEqual(titleSection3, "Equipment")
    }

    func testCellForRowAt() {
        // Given

        // When
        let cellSection0Row0 = dataSource.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? VehicleDetailCell
        let cellSection1Row3 = dataSource.tableView(tableView, cellForRowAt: IndexPath(row: 3, section: 1)) as? VehicleDetailCell
        let cellSection2Row2 = dataSource.tableView(tableView, cellForRowAt: IndexPath(row: 2, section: 2)) as? VehicleDetailCell
        let cellSection3Row4 = dataSource.tableView(tableView, cellForRowAt: IndexPath(row: 4, section: 3)) as? VehicleDetailCell

        // Then
        XCTAssertEqual(cellSection0Row0?.titleLabel.text, "Engine Size:")
        XCTAssertEqual(cellSection1Row3?.titleLabel.text, "Transmission:")
        XCTAssertEqual(cellSection2Row2?.valueLabel.text, "2015/03/31 09:00:00")
        XCTAssertEqual(cellSection3Row4?.titleLabel.text, "")
    }


    func testHeightForRowAt() {
        // Given

        // When
        let heightForRow = dataSource.tableView(tableView, heightForRowAt: IndexPath(row: 0, section: 0))

        // Then
        XCTAssertEqual(heightForRow, UITableView.automaticDimension)
    }

    func testEstimatedHeightForRowAt() {
        // Given

        // When
        let estimatedHeightForRow = dataSource.tableView(tableView, estimatedHeightForRowAt: IndexPath(row: 0, section: 0))

        // Then
        XCTAssertEqual(estimatedHeightForRow, 40)
    }
}

