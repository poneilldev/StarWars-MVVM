//
//  Starship.swift
//  StarWars
//
//  Created by Paul O'Neill on 2/8/22.
//

import Foundation

protocol StarshipProtocol: Codable {
    var name: String { get }
    var model: String { get }
    var manufacturer: String { get }
    var costInCredits: String { get }
    var starshipClass: String { get }
    var pilots: [String] { get }
    var films: [String] { get }
    var url: String { get }
}

class Starship: StarshipProtocol {
    let name, model, manufacturer, costInCredits: String
    let starshipClass: String
    let pilots: [String]
    let films: [String]
    let url: String
}
