//
//  PersonDetailViewController+ViewModel.swift
//  StarWars
//
//  Created by Paul O'Neill on 2/28/22.
//

import Combine
import Foundation
import UIKit

extension PersonDetailViewController {
    enum PersonDetailsError: Error {
        case badImageURL
        case unableToLoadImage(Error)
    }
    
    class ViewModel {
        let service: PersonServiceProtocol
        
        let loading = PassthroughSubject<Bool, Never>()
        let person = CurrentValueSubject<PersonProtocol?, Never>(nil)
        let image = CurrentValueSubject<UIImage?, Never>(nil)
        let error = PassthroughSubject<Error?, Never>()
        
        var cancellables = Set<AnyCancellable>()
        
        
        init(person: PersonProtocol, service: PersonServiceProtocol = PersonService()) {
            self.service = service
            self.person.send(person)
        }
        
        func loadPersonDetails(for personID: Int) async throws {
            self.loading.send(true)
            do {
                let person = try await service.getPerson(for: personID)
                self.person.send(person)
            } catch let error {
                self.error.send(error)
            }
            
            self.loading.send(false)
        }
        
        func loadImage(for person: PersonProtocol) async throws -> UIImage {
            guard let imageURL = URL(string: person.image) else {
                throw PersonDetailsError.badImageURL
            }
            
            do {
                return try await NetworkingManager.loadImage(for: imageURL)
            } catch let error {
                throw PersonDetailsError.unableToLoadImage(error)
            }
        }
    }
}
