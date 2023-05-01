//
//  SigninViewController.swift
//  TaliKhata
//
//  Created by Rakibul Haque on 11/4/21.
//

import UIKit
import FirebaseAuth

class SigninViewController: UIViewController {

    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    @IBOutlet var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.text = ""
        
        // If already logged in send to tab view
        if Auth.auth().currentUser != nil {
            performSegue(withIdentifier: "toTabBar", sender: self)
        }
    }

    @IBAction func loginButtonPressed(_ sender: Any) {
        // Validate fields
        if emailTextField.text!.isEmpty {
            errorLabel.text = "Please enter E-mail"
            return
        }
        if passwordTextField.text!.isEmpty {
            errorLabel.text = "Please enter your password"
            return
        }
        
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { [weak self] authResult, err in
            guard self != nil else {return}
            if let err = err{
                print(err.localizedDescription)
                return
            }
            
            if Auth.auth().currentUser == nil {
                self!.errorLabel.text = "Login failed"
                return
            }
        }
        
        // Autheticate
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { [weak self] authResult, err in
            guard let strongSelf = self else {return}
            if let err = err{
                print(err.localizedDescription)
            }
            self!.checkCredentials()
        }
    }
    
    func checkCredentials() {
        if Auth.auth().currentUser != nil {
            self.view.window?.rootViewController = self.storyboard?.instantiateViewController(identifier: "TabBar") as? TabBarViewController
            self.view.window?.makeKeyAndVisible()
        }
        else {
            errorLabel.text = "Invalid credentials"
        }
    }
}
