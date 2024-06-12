//
//  VehicleService.swift
//  Vehicles
//
//  Created by Alexandre Carvalho on 11/06/2024.
//

import Foundation

class VehicleService {
    func fetchVehicles(completion: @escaping ([Vehicle]) -> Void) {
        guard let url = Bundle.main.url(forResource: "vehicles_dataset", withExtension: "json") else {
            completion([])
            return
        }

        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let vehicles = try decoder.decode([Vehicle].self, from: data)
            completion(vehicles)
        } catch {
            print("Error decoding JSON: \(error)")
            completion([])
        }
    }
}
