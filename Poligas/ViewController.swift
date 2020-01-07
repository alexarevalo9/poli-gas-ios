//
//  ViewController.swift
//  Poligas
//
//  Created by Alex Arevalo on 12/11/19.
//  Copyright © 2019 Quantum. All rights reserved.
//

import UIKit
import FirebaseAuth


class ViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func loginButton(_ sender: Any) {
        
        guard let email = emailTextField.text,
            let password = passwordTextField.text else {
            return
        }
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            print("Result: \(result)")
            print("Error: \(error)")
            
            if error != nil {
                self.presentAlertWhit(title: "Error", message: error?.localizedDescription ?? "Ups! An Error Ocurred")
            } else {
                self.performSegue(withIdentifier: "loginSuccessSegue", sender: self)
            }
        }
    }
    
    private func presentAlertWhit(title : String, message : String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAlertAction = UIAlertAction(title: "OK", style: .default) { _ in
            self.emailTextField.text = ""
            self.passwordTextField.text = ""
            self.emailTextField.becomeFirstResponder()
        }
        
        alertController.addAction(okAlertAction)
        present(alertController, animated: true, completion: nil)
    }
    
}

