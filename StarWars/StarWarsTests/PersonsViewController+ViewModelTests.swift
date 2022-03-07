//
//  PersonsViewController+ViewModelTests.swift
//  StarWarsTests
//
//  Created by Paul O'Neill on 2/22/22.
//

import XCTest
@testable import StarWars

class PersonsViewController_ViewModelTests: XCTestCase {
    var sut: PersonsViewController.ViewModel!

    override func tearDownWithError() throws {
        sut = nil
    }

    func testGetNumPersons_3Persons_3() async {
        let person1 = Test_Person(name: "Ryan")
        let person2 = Test_Person(name: "Joe")
        let person3 = Test_Person(name: "Cal")
        
        let service = MockPersonService(persons: [person1, person2, person3])
        sut = PersonsViewController.ViewModel(service: service)
        
        do {
            try await sut.loadAllPersons()
        } catch {
            XCTFail("Failed to load persons")
        }
        
        XCTAssertEqual(sut.getNumPersons(), 3)
    }
    
    func testGetPerson_3Persons_returnThirdPerson() async {
        let person1 = Test_Person(name: "Ryan")
        let person2 = Test_Person(name: "Joe")
        let person3 = Test_Person(name: "Cal")
        
        sut = PersonsViewController.ViewModel(service: MockPersonService(persons: [person1, person2, person3]))
        
        do {
            try await sut.loadAllPersons()
        } catch {
            XCTFail("Failed to load persons")
        }
        
        XCTAssertEqual(sut.getPerson(for: IndexPath(row: 2, section: 0))?.name, person3.name)
    }
    
    func testFilterResults_3PeopleTypeR_shouldReturn1() async {
        let person1 = Test_Person(name: "Ryan")
        let person2 = Test_Person(name: "Joe")
        let person3 = Test_Person(name: "Cal")
        
        sut = PersonsViewController.ViewModel(service: MockPersonService(persons: [person1, person2, person3]))
        
        do {
            try await sut.loadAllPersons()
        } catch {
            XCTFail("Failed to load persons")
        }
        
        sut.filterResults(for: "R")
        
        guard let ryan = sut.getPerson(for: IndexPath(row: 0, section: 0)) else {
            XCTFail("There should be a result here.")
            return
        }
        
        XCTAssertEqual(ryan.name, person1.name)
    }
    
    func testFilterResults_3PeopleTypeNothing_shouldReturn3() async {
        let person1 = Test_Person(name: "Ryan")
        let person2 = Test_Person(name: "Joe")
        let person3 = Test_Person(name: "Cal")
        
        sut = PersonsViewController.ViewModel(service: MockPersonService(persons: [person1, person2, person3]))
        
        do {
            try await sut.loadAllPersons()
        } catch {
            XCTFail("Failed to load persons")
        }
        
        sut.filterResults(for: "")
        
        XCTAssertEqual(sut.getNumPersons(), 3)
    }
}
