//
//  PersonsViewController.swift
//  StarWars
//
//  Created by Paul O'Neill on 2/8/22.
//

import Combine
import UIKit

class PersonsViewController: UIViewController {
    var contentView = MainView()
    let viewModel: ViewModel
    
    let searchController = UISearchController(searchResultsController: nil)
    var cancellables = Set<AnyCancellable>()
    
    override func loadView() {
        view = contentView
    }
    
    init(_ viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bind()
    }
    
    func setupUI() {
        contentView.tableView.delegate = self
        contentView.tableView.dataSource = self
        
        navigationItem.title = "Star Wars Characters"
        navigationItem.searchController = searchController
        
        searchController.searchResultsUpdater = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        Task {
            try await viewModel.loadAllPersons()
        }
    }
    
    func bind() {
        viewModel.$filteredResults
            .receive(on: DispatchQueue.main)
            .sink { results in
                self.contentView.tableView.reloadData()
            }.store(in: &cancellables)
        
        viewModel.$loading
            .receive(on: DispatchQueue.main)
            .sink { loading in
                if loading {
                    self.contentView.activityIndicator.startAnimating()
                } else {
                    self.contentView.activityIndicator.stopAnimating()
                }
            }.store(in: &cancellables)
        
        viewModel.$error
            .receive(on: DispatchQueue.main)
            .sink { error in
                if let err = error {
                    self.handleError(err)
                }
            }.store(in: &cancellables)
    }
}

// MARK: - UITableView Data Source and Delegate
extension PersonsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let person = self.viewModel.getPerson(for: indexPath) else { return }
        let viewModel = PersonDetailViewController.ViewModel(person: person)
        navigationController?.pushViewController(PersonDetailViewController(viewModel: viewModel), animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.getNumPersons()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PersonTableViewCell.identifier, for: indexPath) as! PersonTableViewCell
        cell.configureCell(self.viewModel.getPerson(for: indexPath))
        return cell
    }
}

extension PersonsViewController: UISearchResultsUpdating, UISearchControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        viewModel.filterResults(for: text)
    }
}

