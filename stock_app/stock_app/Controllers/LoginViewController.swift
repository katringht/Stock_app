//
//  LoginViewController.swift
//  stock_app
//
//  Created by Ekaterina Tarasova on 06.08.2021.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet var loginView: UIView!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var loginLabal: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.layer.cornerRadius = 10
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        loginView.bindToKeyboard()
    }
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
