//
//  LogInVC.swift
//  FoodTruck
//
//  Created by Javier Gomez on 1/6/19.
//  Copyright © 2019 Javier Gomez. All rights reserved.
//

import UIKit

class LogInVC: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func logInButtonTapped(_ sender: Any) {
        guard let email = emailTextField.text, emailTextField.text != "" else {
            showAlert(title: "Error", message: "Please, enter an email")
            return
        }
        
        guard let password = passwordTextField.text, passwordTextField.text != "" else {
            showAlert(title: "Error", message: "Please, enter a password")
            return
        }
        
        AuthService.instance.registerUser(email: email, password: password) { (Success) in
            if Success {
                AuthService.instance.logIn(email: email, password: password, completion: { (Success) in
                    if (Success) {
                        self.dismiss(animated: true, completion: nil)
                    } else {
                        OperationQueue.main.addOperation {
                            self.showAlert(title: "Error", message: "Incorrect password")
                        }
                    }
                })
            } else {
                OperationQueue.main.addOperation {
                    self.showAlert(title: "Error", message: "An unknown error occurred saving the account")
                }
            }
        }
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func showAlert(title: String?, message: String?) -> Void {
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
