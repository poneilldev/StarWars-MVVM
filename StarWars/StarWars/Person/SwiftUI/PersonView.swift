//
//  PersonView.swift
//  StarWars
//
//  Created by Paul O'Neill on 2/26/22.
//

import SwiftUI

struct PersonView: View {
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.loading {
                    ProgressView()
                } else {
                    List {
                        ForEach(viewModel.filteredResults, id: \.name) { person in
                            NavigationLink(destination: PersonDetailsView(person: person)) {
                                PersonViewCell(person: person)
                            }
                        }
                    }
                    .searchable(text: $viewModel.searchBarText, prompt: "Search name...")
                    .onChange(of: viewModel.searchBarText) { _ in
                        viewModel.filterResults()
                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Star Wars Characters")
        }
    }
}

struct PersonViewCell: View {
    let person: PersonProtocol
    
    var body: some View {
        HStack {
            Image(systemName: "star")
            VStack {
                HStack {
                    Text(person.name)
                    Spacer()
                }
                if let homePlanet = person.bornLocation {
                    HStack {
                        Text(homePlanet)
                            .font(.footnote)
                        Spacer()
                    }
                }
            }
            Spacer()
        }
    }
}

struct PersonView_Previews: PreviewProvider {
    
    static var previews: some View {
        PersonView(viewModel: PersonView.ViewModel(service: PersonService()))
    }
}
