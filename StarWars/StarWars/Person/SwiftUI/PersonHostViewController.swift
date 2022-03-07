//
//  PersonHostViewController.swift
//  StarWars
//
//  Created by Paul O'Neill on 2/26/22.
//

import UIKit
import SwiftUI

class PersonHostViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let childView = UIHostingController(rootView: PersonView(viewModel: .init()))
        addChild(childView)
        childView.view.frame = view.frame
        view.addSubview(childView.view)
        childView.didMove(toParent: self)
    }

}
