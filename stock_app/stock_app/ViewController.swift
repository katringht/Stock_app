//
//  ViewController.swift
//  stock_app
//
//  Created by Ekaterina Tarasova on 05.03.2021.
//

import UIKit


class ViewController: UIViewController, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet var field: UITextField!
    @IBOutlet var table: UITableView!
    var stock = [Stock]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        field.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        field.layer.cornerRadius = 25
        field.layer.borderWidth = 0.8
        field.layer.borderColor = UIColor.black.cgColor
        field.layer.masksToBounds = true
        field.textColor = UIColor.black
        field.attributedPlaceholder = NSAttributedString(string: "Find company or ticker", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        field.leftViewMode = UITextField.ViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let image = UIImage(systemName: "magnifyingglass")
        imageView.image = image
        field.leftView = imageView
        field.leftView?.tintColor = UIColor.black

        
    }
    //field
    func textFieldShouldReturn(_ textField: UITextField)-> Bool {
        search()
        
//        for textField in self.view.subviews where textField is UITextField {
//            textField.resignFirstResponder()
//        }
        
        return true
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    func search() {
        
    }
    
    //table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stock.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

struct Stock {
    
}

