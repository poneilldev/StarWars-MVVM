//
//  PersonService.swift
//  StarWars
//
//  Created by Paul O'Neill on 2/19/22.
//

import Foundation

protocol PersonServiceProtocol {
    func getPerson(for personId: Int) async throws -> PersonProtocol
    func getAllPersons() async throws -> [PersonProtocol]
}

struct PersonService: PersonServiceProtocol {
    static private let basePath = "https://poneilldev.github.io/starwars-api/"
    
    func getPerson(for personId: Int) async throws -> PersonProtocol {
        let url = URL(string: Self.basePath + "id/\(personId).json")!
        return try await NetworkingManager.loadResource(type: Person.self, with: url)
    }
    
    func getAllPersons() async throws -> [PersonProtocol] {
        let url = URL(string: Self.basePath + "all.json")!
        return try await NetworkingManager.loadResource(type: [Person].self, with: url)
    }
    
}
