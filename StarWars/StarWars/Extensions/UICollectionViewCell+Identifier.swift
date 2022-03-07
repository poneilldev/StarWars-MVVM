//
//  UICollectionViewCell+Identifier.swift
//  StarWars
//
//  Created by Paul O'Neill on 2/21/22.
//

import UIKit

extension UICollectionViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}
