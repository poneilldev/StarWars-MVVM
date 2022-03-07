//
//  Person.swift
//  StarWars
//
//  Created by Paul O'Neill on 2/8/22.
//

import Foundation

protocol PersonProtocol: Codable {
    var id: Int { get }
    var name: String { get }
    var gender: String { get }
    var wiki: String { get }
    var image: String { get }
    var bornLocation: String? { get }
}

struct Person: PersonProtocol {
    let id: Int
    let name: String
    let gender: String
    let wiki: String
    let image: String
    let bornLocation: String?
}
