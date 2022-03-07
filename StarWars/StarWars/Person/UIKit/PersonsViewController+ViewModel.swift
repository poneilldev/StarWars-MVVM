//
//  PersonsViewController+ViewModel.swift
//  StarWars
//
//  Created by Paul O'Neill on 2/8/22.
//

import Combine
import Foundation
import SwiftUI

extension PersonsViewController {
    class ViewModel {
        let service: PersonServiceProtocol
        @Published private(set) var results: [PersonProtocol] = []
        @Published private(set) var filteredResults: [PersonProtocol] = []
        @Published private(set) var loading: Bool = false
        @Published private(set) var error: Error? = nil
        
        var cancellables = Set<AnyCancellable>()
        
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
            guard indexPath.section == 0, indexPath.row < filteredResults.count, indexPath.row >= 0 else { return nil }
            return filteredResults[indexPath.row]
        }
        
        func filterResults(for text: String) {
            guard !text.isEmpty else {
                self.filteredResults = self.results
                return
            }
            let filteredResults = self.results.filter({ $0.name.contains(text) })
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
