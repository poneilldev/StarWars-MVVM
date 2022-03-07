//
//  Test_Starship.swift
//  StarWarsTests
//
//  Created by Paul O'Neill on 2/8/22.
//

import Foundation
@testable import StarWars

struct Test_Starhip: StarshipProtocol {
    var name: String
    var model: String
    var manufacturer: String
    var costInCredits: String
    var starshipClass: String
    var pilots: [String]
    var films: [String]
    var url: String
}
