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
    
    func getPerson(for personId: Int) async throws -> PersonProtocol {
        let url = URL(string: "https://poneilldev.github.io/starwars-api/id/\(personId).json")!
        return try await NetworkingManager.loadResource(type: Person.self, with: url)
    }
    
    func getAllPersons() async throws -> [PersonProtocol] {
        let url = URL(string: "https://poneilldev.github.io/starwars-api/all.json")!
        return try await NetworkingManager.loadResource(type: [Person].self, with: url)
    }
    
}
