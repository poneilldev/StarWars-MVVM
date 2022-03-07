//
//  PersonsViewController+MainView.swift
//  StarWars
//
//  Created by Paul O'Neill on 2/8/22.
//

import Foundation
import UIKit

extension PersonsViewController {
    class MainView: UIView {
        let tableView: UITableView
        let activityIndicator: UIActivityIndicatorView
        
        override init(frame: CGRect) {
            tableView = UITableView(frame: frame)
            tableView.register(PersonTableViewCell.self, forCellReuseIdentifier: PersonTableViewCell.identifier)
            tableView.translatesAutoresizingMaskIntoConstraints = false
            tableView.tableFooterView = UIView()
            
            activityIndicator = UIActivityIndicatorView(style: .large)
            activityIndicator.translatesAutoresizingMaskIntoConstraints = false
            
            super.init(frame: frame)
            backgroundColor = .systemBackground
            
            addSubview(tableView)
            addSubview(activityIndicator)
            
            activityIndicator.startAnimating()
            
            NSLayoutConstraint.activate([
                tableView.topAnchor.constraint(equalTo: topAnchor),
                tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
                tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
                tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
                
                activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
                activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
            
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}
//
//extension PersonsViewController2 {
//    class MainView: UIView {
//        let tableView: UITableView
//        let activityIndicator: UIActivityIndicatorView
//        
//        override init(frame: CGRect) {
//            tableView = UITableView(frame: frame)
//            tableView.register(PersonTableViewCell.self, forCellReuseIdentifier: PersonTableViewCell.identifier)
//            tableView.translatesAutoresizingMaskIntoConstraints = false
//            tableView.tableFooterView = UIView()
//            
//            activityIndicator = UIActivityIndicatorView(style: .large)
//            activityIndicator.translatesAutoresizingMaskIntoConstraints = false
//            
//            super.init(frame: frame)
//            backgroundColor = .systemBackground
//            
//            addSubview(tableView)
//            addSubview(activityIndicator)
//            
//            activityIndicator.startAnimating()
//            
//            NSLayoutConstraint.activate([
//                tableView.topAnchor.constraint(equalTo: topAnchor),
//                tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
//                tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
//                tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
//                
//                activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
//                activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
//            ])
//            
//        }
//        
//        required init?(coder: NSCoder) {
//            fatalError("init(coder:) has not been implemented")
//        }
//    }
//}
//
//extension PersonsViewController3 {
//    class MainView: UIView {
//        let tableView: UITableView
//        let activityIndicator: UIActivityIndicatorView
//        
//        override init(frame: CGRect) {
//            tableView = UITableView(frame: frame)
//            tableView.register(PersonTableViewCell.self, forCellReuseIdentifier: PersonTableViewCell.identifier)
//            tableView.translatesAutoresizingMaskIntoConstraints = false
//            tableView.tableFooterView = UIView()
//            
//            activityIndicator = UIActivityIndicatorView(style: .large)
//            activityIndicator.translatesAutoresizingMaskIntoConstraints = false
//            
//            super.init(frame: frame)
//            backgroundColor = .systemBackground
//            
//            addSubview(tableView)
//            addSubview(activityIndicator)
//            
//            activityIndicator.startAnimating()
//            
//            NSLayoutConstraint.activate([
//                tableView.topAnchor.constraint(equalTo: topAnchor),
//                tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
//                tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
//                tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
//                
//                activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
//                activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
//            ])
//            
//        }
//        
//        required init?(coder: NSCoder) {
//            fatalError("init(coder:) has not been implemented")
//        }
//    }
//}
