//
//  VehicleServiceTests.swift
//  VehiclesTests
//
//  Created by Alexandre Carvalho on 13/06/2024.
//

import XCTest
@testable import Vehicles

class VehicleServiceTests: XCTestCase {
    
    func testFetchVehicles() {
        let expectation = self.expectation(description: "Fetch vehicles completion")
        let service = VehicleService()
        
        // Act
        service.fetchVehicles { (vehicles) in
            // Assert
            XCTAssertGreaterThan(vehicles.count, 0, "Expected more than 0 vehicles")
            
            // Example assertion for the first vehicle
            XCTAssertEqual(vehicles[0].make.rawValue, "Toyota")
            XCTAssertEqual(vehicles[0].model, "C-HR")
            
            expectation.fulfill()
        }
        
        // Wait for the expectation to be fulfilled (timeout after 5 seconds)
        waitForExpectations(timeout: 5, handler: nil)
    }
}


