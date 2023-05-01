//
//  UserSettingsViewController.swift
//  TaliKhata
//
//  Created by Rakibul Haque on 11/4/21.
//

import UIKit
import FirebaseAuth

class UserSettingsViewController: UIViewController {

    @IBOutlet weak var shopNameTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var contactTextField: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.text = ""
        shopNameTextField.text = sharedData["shopName"]
        descriptionTextField.text = sharedData["details"]
        addressTextField.text = sharedData["address"]
        contactTextField.text = sharedData["contact"]
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        if shopNameTextField.text!.isEmpty || descriptionTextField.text!.isEmpty || addressTextField.text!.isEmpty || contactTextField.text!.isEmpty {
            errorLabel.text = "Fill in all values!"
            return
        }
        
        let data = UserInfo(shopName: shopNameTextField.text!, details: descriptionTextField.text!, address: addressTextField.text!, contact: contactTextField.text!)
        
        if saveJSON(data: data, fileName: Auth.auth().currentUser?.uid ?? "data") {
            // Open Dashboard
            self.view.window?.rootViewController = self.storyboard?.instantiateViewController(identifier: "TabBar") as? TabBarViewController
            self.view.window?.makeKeyAndVisible()
        }
        else {
            errorLabel.text = "Unable to save"
        }
    }
    
    func saveJSON(data: UserInfo, fileName: String) -> Bool {
        let jsonData = try! JSONEncoder().encode(data)
        let jsonString = String(data: jsonData, encoding: .utf8)!
        
        if let documentDirectory = FileManager.default.urls(for: .documentDirectory,
                                                            in: .userDomainMask).first {
            let url = documentDirectory.appendingPathComponent("\(fileName).json")
            print(url)
            
            do {
                try jsonString.write(to: url,
                                     atomically: true,
                                     encoding: .utf8)
                return true
            } catch {
                print("Error: \(error)")
            }
        }
        return false
    }
}
