//
//  SignupViewController.swift
//  TaliKhata
//
//  Created by Rakibul Haque on 11/4/21.
//

import UIKit
import FirebaseAuth

class SignupViewController: UIViewController {
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var retypePasswordTextField: UITextField!
    
    @IBOutlet var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.text = ""
    }
    
    @IBAction func registerButtonPressed(_ sender: Any) {
        // Validate fields
        if emailTextField.text!.isEmpty {
            errorLabel.text = "Please enter E-mail"
            return
        }
        
        if passwordTextField.text!.isEmpty {
            errorLabel.text = "Please enter your password"
            return
        }
        
        if retypePasswordTextField.text!.isEmpty {
            errorLabel.text = "Please re-enter your password"
            return
        }
        
        if passwordTextField.text != retypePasswordTextField.text {
            errorLabel.text = "Passwords didn't match"
            return
        }
        
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (authResult, error) in
            guard let user = authResult?.user,error == nil else {
                print("Error\(error?.localizedDescription)")
                return
            }
        }
        
        // Goto Dashboard
        self.view.window?.rootViewController = self.storyboard?.instantiateViewController(identifier: "TabBar") as? TabBarViewController
        self.view.window?.makeKeyAndVisible()
    }
    
    

}
