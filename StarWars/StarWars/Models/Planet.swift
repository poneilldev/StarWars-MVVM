//
//  Planet.swift
//  StarWars
//
//  Created by Paul O'Neill on 2/8/22.
//

import Foundation

protocol PlanetProtocol: Codable {
    var name: String { get }
    var rotationPeriod: String { get }
    var population: String { get }
    var films: [String] { get }
}

struct Planet: PlanetProtocol {
    let name: String
    let rotationPeriod: String
    let population: String
    let films: [String]
}
