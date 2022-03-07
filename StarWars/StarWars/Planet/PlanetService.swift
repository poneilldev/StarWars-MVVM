//
//  PlanetService.swift
//  StarWars
//
//  Created by Paul O'Neill on 2/22/22.
//

import Foundation

protocol PlanetServiceProtocol {
    func getPlanet(for id: Int) async throws -> PlanetProtocol
    func getAllPlanets() async throws -> [PlanetProtocol]
}

enum PlanetServiceError: Error {
    case badHTTPResponse
    case decodingError(Error)
}

struct PlanetService: PlanetServiceProtocol {
    private static let path = "planet/"
    
    func getPlanet(for id: Int) async throws -> PlanetProtocol {
        let url = URL(string: "https://swapi.dev/api/\(PlanetService.path)/\(id)")!
        return try await NetworkingManager.loadResource(type: Planet.self, with: url)
    }
    
    func getAllPlanets() async throws -> [PlanetProtocol] {
        let url = URL(string: "https://swapi.dev/api/\(PlanetService.path)/")!
        return try await NetworkingManager.loadResource(type: [Planet].self, with: url)
    }
}
