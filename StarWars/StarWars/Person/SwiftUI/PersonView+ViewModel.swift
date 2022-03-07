//
//  PersonView+ViewModel.swift
//  StarWars
//
//  Created by Paul O'Neill on 2/28/22.
//

import Foundation

extension PersonView {
    @MainActor
    class ViewModel: ObservableObject {
        let service: PersonServiceProtocol
        
        @Published private(set) var results: [PersonProtocol] = []
        @Published private(set) var filteredResults: [PersonProtocol] = []
        @Published private(set) var loading: Bool = false
        @Published private(set) var error: Error? = nil
        @Published var searchBarText: String = ""

        init(service: PersonServiceProtocol = PersonService()) {
            self.service = service
            Task {
                try await loadAllPersons()
            }
        }

        func getNumPersons() -> Int {
            return filteredResults.count
        }

        func getPerson(for indexPath: IndexPath) -> PersonProtocol? {
            return filteredResults[indexPath.row]
        }

        func updateSearchText(_ text: String) {
            self.searchBarText = text
            filterResults()
        }

        func filterResults() {
            guard !searchBarText.isEmpty else {
                self.filteredResults = self.results
                return
            }
            let filteredResults = self.results.filter({ $0.name.contains(searchBarText) })
            self.filteredResults = filteredResults
        }

        func loadAllPersons() async throws {
            self.loading = true
            do {
                let persons = try await service.getAllPersons()
                self.results = persons
                self.filteredResults = persons
            } catch let error {
                self.error = error
            }
            self.loading = false
        }
    }
}
