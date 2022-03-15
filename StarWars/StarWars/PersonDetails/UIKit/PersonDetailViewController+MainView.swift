//
//  PersonDetailViewController+MainView.swift
//  StarWars
//
//  Created by Paul O'Neill on 2/22/22.
//

import Foundation
import UIKit

extension PersonDetailViewController {
    class MainView: UIView {
        let personImageView: UIImageView
        let nameLabel: UILabel
        
        override init(frame: CGRect) {
            nameLabel = UILabel()
            nameLabel.translatesAutoresizingMaskIntoConstraints = false
            
            personImageView = UIImageView()
            personImageView.contentMode = .scaleAspectFit
            personImageView.translatesAutoresizingMaskIntoConstraints = false
            
            super.init(frame: frame)
            
            backgroundColor = .systemBackground
            
            addSubview(nameLabel)
            addSubview(personImageView)
            
            NSLayoutConstraint.activate([
                personImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
                personImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
                personImageView.heightAnchor.constraint(equalToConstant: 150),
                personImageView.widthAnchor.constraint(equalToConstant: 150),
                
                nameLabel.topAnchor.constraint(equalTo: personImageView.bottomAnchor, constant: 16),
                nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
            ])
            
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}
