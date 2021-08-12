//
//  CartViewController.swift
//  stock_app
//
//  Created by Ekaterina Tarasova on 12.08.2021.
//

import UIKit

class CartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
