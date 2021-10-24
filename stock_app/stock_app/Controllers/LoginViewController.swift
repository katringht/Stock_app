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
    @IBOutlet var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.layer.cornerRadius = 10
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        //animation when keyboard is appearing
        loginButton.bindToKeyboard()
        loginLabal.bindToKeyboard()
        stackView.bindToKeyboard()
        
        // user is already logged in
        if UserDefaults.standard.bool(forKey: "USERDEFAULTLOGIN") {
            showView()
        }
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func loginButton(_ sender: Any) {
        guard let email = emailTextField.text, let password = passwordTextField.text else {return}
        
        if email.isValidEmail && password.isValidPassword{
            // set the default user's login
            UserDefaults.standard.set(true, forKey: "USERDEFAULTLOGIN")
            //navigate to screen with stocks
            showView()
        } else {
            showError()
            
        }
    }
    
    func showError() {
        let ac = UIAlertController(title: "Invalid password or email", message: "Example email: rrr@rr.r Password: at least eight characters.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    func showView() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let secondVC = storyboard.instantiateViewController(identifier: "StockViewController") as! StockViewController
        show(secondVC, sender: self)
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
