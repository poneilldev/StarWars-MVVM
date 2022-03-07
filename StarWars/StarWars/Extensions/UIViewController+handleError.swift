//
//  UIViewController+handleError.swift
//  StarWars
//
//  Created by Paul O'Neill on 2/22/22.
//

import Foundation
import UIKit

extension UIViewController {
    public func handleError(_ error: Error) {
        let alertVC = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertVC.addAction(okayAction)
        present(alertVC, animated: true, completion: nil)
    }
}
