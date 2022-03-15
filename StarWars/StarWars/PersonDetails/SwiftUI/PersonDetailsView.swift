//
//  PersonDetailsView.swift
//  StarWars
//
//  Created by Paul O'Neill on 3/15/22.
//

import SwiftUI

struct PersonDetailsView: View {
    let person: PersonProtocol
    
    var body: some View {
        VStack {
            Text("Name: \(person.name)")
            Text("Wiki: \(person.wiki)")
            Text("Gender: \(person.gender)")
            Text("Image URL: \(person.image)")
            Text("ID: \(person.id)")
        }
    }
}

struct PersonDetails_Previews: PreviewProvider {
    static var previews: some View {
        PersonDetailsView(person: Person(id: 1, name: "Luke", gender: "mail", wiki: "", image: "", bornLocation: nil))
    }
}
