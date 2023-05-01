//
//  AddProductViewController.swift
//  TaliKhata
//
//  Created by Rakibul Haque on 11/5/21.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseDatabase

class AddProductViewController: UIViewController {

    @IBOutlet weak var productNameTextField: UITextField!
    @IBOutlet weak var remainingQuantityTextField: UITextField!
    @IBOutlet weak var actualPriceTextField: UITextField!
    @IBOutlet weak var sellingPriceTextField: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    var ref = DatabaseReference.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.text = ""
        self.ref=Database.database().reference()
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        if productNameTextField.text!.isEmpty || remainingQuantityTextField.text!.isEmpty || actualPriceTextField.text!.isEmpty || sellingPriceTextField.text!.isEmpty {
            errorLabel.text = "Fill in all values!"
            return
        }
        
        let dict=["name":productNameTextField.text!,"quantity":remainingQuantityTextField.text!,"actual_price":actualPriceTextField.text!,"selling_price":sellingPriceTextField.text!]
        
        let userId = Auth.auth().currentUser!.uid
        
        self.ref.child(userId).childByAutoId().setValue(dict)
        
        // Open Products
        performSegue(withIdentifier: "toProducts", sender: self)
    }
    
}
