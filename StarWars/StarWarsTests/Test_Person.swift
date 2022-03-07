//
//  Test_Person.swift
//  StarWarsTests
//
//  Created by Paul O'Neill on 2/8/22.
//

import Foundation
@testable import StarWars

struct Test_Person: PersonProtocol {
    var id: Int
    var name: String
    var gender: String
    var wiki: String
    var image: String
    var bornLocation: String?
    
    init(name: String) {
        self.name = name
        self.id = 2
        self.gender = "Male"
        self.wiki = "text"
        self.image = "www.example.com/test-image.jpg"
        self.bornLocation = "Dagobah"
    }
}
