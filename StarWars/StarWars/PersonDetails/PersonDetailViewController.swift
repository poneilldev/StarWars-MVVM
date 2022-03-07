//
//  PersonDetailViewController.swift
//  StarWars
//
//  Created by Paul O'Neill on 2/22/22.
//

import UIKit

class PersonDetailViewController: UIViewController {
    let contentView = MainView()
    let viewModel: ViewModel

    override func loadView() {
        view = contentView
    }
    
    init(viewModel: PersonDetailViewController.ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }

    private func bind() {
        self.viewModel.person
            .receive(on: DispatchQueue.main)
            .compactMap { $0 }
            .sink { person in
                Task {
                    self.contentView.personImageView.image = try await self.viewModel.loadImage(for: person)
                    self.contentView.nameLabel.text = person.name
                }
            }.store(in: &self.viewModel.cancellables)
    }
}
