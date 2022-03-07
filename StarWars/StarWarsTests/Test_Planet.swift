//
//  Test_Planet.swift
//  StarWarsTests
//
//  Created by Paul O'Neill on 2/8/22.
//

import Foundation
@testable import StarWars

struct Test_Planet: PlanetProtocol {
    var name: String = "Dagobah"
    var rotationPeriod: String = "4818"
    var population: String
    var films: [String] = []
}
