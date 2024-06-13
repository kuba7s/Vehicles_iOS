//
//  VehicleDataSourceTests.swift
//  VehiclesTests
//
//  Created by Alexandre Carvalho on 13/06/2024.
//

import XCTest
@testable import Vehicles

class VehicleListViewControllerTests: XCTestCase {

    var viewController: VehicleListViewController!
    var mockVehicleService: MockVehicleService!
    var mockDataSource: VehicleDataSource!
    var mockDelegate: MockVehicleDelegate!
    var mockFavoritingDelegate: MockFavoritingDelegate!

    override func setUp() {
        super.setUp()

        mockVehicleService = MockVehicleService()
        mockDataSource = VehicleDataSource()
        mockDelegate = MockVehicleDelegate()
        mockFavoritingDelegate = MockFavoritingDelegate()

        viewController = VehicleListViewController(vehicleService: mockVehicleService, dataSource: mockDataSource, delegate: mockDelegate)
        viewController.favoritingDelegate = mockFavoritingDelegate

        // Load the view hierarchy
        viewController.loadViewIfNeeded()
    }

    override func tearDown() {
        viewController = nil
        mockVehicleService = nil
        mockDataSource = nil
        mockDelegate = nil
        mockFavoritingDelegate = nil

        super.tearDown()
    }

    func testViewDidLoad_setsUpUI() {
        // Given
        XCTAssertEqual(viewController.view.backgroundColor, .themeColor(.background), "Background color should be set")

        // When
        let tableView = viewController.view.subviews.first as? UITableView

        // Then
        XCTAssertNotNil(tableView, "TableView should be added to the view")
        XCTAssertEqual(tableView?.dataSource as? VehicleDataSource, mockDataSource, "TableView dataSource should be set")
        XCTAssertEqual(tableView?.delegate as? VehicleDelegate, mockDelegate, "TableView delegate should be set")
    }

    func testViewDidLoad_fetchesVehicles() {
        // Given
        let vehicles = createDummyVehicles(count: 5)
        mockVehicleService.stubbedVehicles = vehicles

        // When
        viewController.viewDidLoad()

        // Then
        XCTAssertEqual(viewController.vehicles, vehicles, "Vehicles should be set from service")
        XCTAssertEqual(viewController.originalVehiclesList, vehicles, "Original vehicle list should be set from service")
        XCTAssertEqual(mockDataSource.viewModels.count, vehicles.count, "DataSource should be updated with vehicles")
    }

    func testUpdateFavoriteStatus_togglesFavorite() {
        // Given
        let vehicle = createDummyVehicles(count: 1).first!
        viewController.vehicles = [vehicle]
        viewController.originalVehiclesList = [vehicle]
        viewController.updateDataSource(with: [vehicle])

        // When
        viewController.updateFavoriteStatus(for: vehicle)

        // Then
        XCTAssertEqual(viewController.vehicles.first?.favourite, true, "Favorite status should be toggled")
        XCTAssertTrue(mockFavoritingDelegate.didSelectFavoriteCalled, "Delegate should be called")
        XCTAssertEqual(mockFavoritingDelegate.favoriteVehicle, vehicle, "Correct vehicle should be passed to delegate")
    }

    // Helper function to create dummy vehicles
    private func createDummyVehicles(count: Int) -> [Vehicle] {
        var vehicles: [Vehicle] = []
        for i in 0..<count {
            let vehicle = Vehicle(
                make: Make(rawValue: "Audi")!,
                model: "A4",
                engineSize: "the18L",
                fuel: Fuel.petrol.rawValue,
                year: 2022,
                mileage: 1000 * i,
                auctionDateTime: "2024/06/15 09:00:00",
                startingBid: 20000 + i * 1000,
                favourite: false,
                details: Details(
                    specification: Specification(
                        vehicleType: .car,
                        colour: .red,
                        fuel: .petrol,
                        transmission: .manual,
                        numberOfDoors: 4,
                        co2Emissions: .the139GKM,
                        noxEmissions: 200,
                        numberOfKeys: 2
                    ),
                    ownership: Ownership(
                        logBook: .present,
                        numberOfOwners: 1,
                        dateOfRegistration: .the20150331090000
                    ),
                    equipment: []
                )
            )
            vehicles.append(vehicle)
        }
        return vehicles
    }
}

// Mock classes

class MockVehicleService: VehicleService {
    var stubbedVehicles: [Vehicle] = []

    override func fetchVehicles(completion: @escaping ([Vehicle]) -> Void) {
        completion(stubbedVehicles)
    }
}

class MockVehicleDelegate: VehicleDelegate {
    var setupCalled = false

    override func setup(_ viewController: VehicleListViewController) {
        setupCalled = true
    }
}

class MockFavoritingDelegate: VehicleFavoritingDelegate {
    var didSelectFavoriteCalled = false
    var favoriteVehicle: Vehicle?

    func setList(with vehicles: [Vehicle]) {
        // no-op
    }

    func didSelectFavorite(vehicle: Vehicle) {
        didSelectFavoriteCalled = true
        favoriteVehicle = vehicle
    }
}
