//
//  UITableViewCell+Identifier.swift
//  StarWars
//
//  Created by Paul O'Neill on 2/21/22.
//

import UIKit

extension UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}
