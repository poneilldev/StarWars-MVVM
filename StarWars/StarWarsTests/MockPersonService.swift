//
//  MockPersonService.swift
//  StarWarsTests
//
//  Created by Paul O'Neill on 2/22/22.
//

import Foundation
@testable import StarWars

struct MockPersonService: PersonServiceProtocol {
    
    let persons: [Test_Person]
    let error: Error?
    
    init(persons: [Test_Person]) {
        self.persons = persons
        self.error = nil
    }
    
    init(error: Error) {
        self.error = error
        self.persons = []
    }
    
    func getPerson(for personId: Int) async throws -> PersonProtocol {
        return persons.first!
    }
    
    func getAllPersons() async throws -> [PersonProtocol] {
        if let error = self.error {
            throw error
        }
        return persons
    }
}
