//
//  PersonTableViewCell.swift
//  StarWars
//
//  Created by Paul O'Neill on 2/21/22.
//

import UIKit

class PersonTableViewCell: UITableViewCell {
    
    private var loadedImage: UIImage? {
        didSet {
            setNeedsUpdateConfiguration()
        }
    }
    
    private var person: PersonProtocol!
    
    override func updateConfiguration(using state: UICellConfigurationState) {
        updateView()
    }

    func configureCell(_ person: PersonProtocol?) {
        guard let person = person else { return }
        self.person = person
        updateImage(for: person)
        updateView()
    }
    
    private func updateView() {
        var config = defaultContentConfiguration()
        config.text = person.name
        config.secondaryText = person.bornLocation?.capitalized //person.homeworld.first?.capitalized
        config.image = self.loadedImage
        config.imageProperties.cornerRadius = (loadedImage?.size.height ?? 40) / 2
        config.imageProperties.maximumSize = CGSize(width: 40, height: 40)
        self.contentConfiguration = config
    }
    
    private func updateImage(for person: PersonProtocol) {
        guard let imageURL = URL(string: person.image) else { return }
        Task {
            do {
                self.loadedImage = try await NetworkingManager.loadImage(for: imageURL)
            } catch {
                self.loadedImage = UIImage(systemName: "star")
            }
        }
    }
}
