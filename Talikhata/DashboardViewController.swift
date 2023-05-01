//
//  DashboardViewController.swift
//  TaliKhata
//
//  Created by Rakibul Haque on 11/4/21.
//

import UIKit
import FirebaseAuth

var sharedData: [String: String] = [
    "shopName": "", "details": "", "address": "", "contact": ""
]

class DashboardViewController: UIViewController {
    
    @IBOutlet weak var shopNameLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        let data = parseJSON(fileName: Auth.auth().currentUser?.uid ?? "data")
        sharedData["shopName"] = data.shopName
        sharedData["details"] = data.details
        sharedData["address"] = data.address
        sharedData["contact"] = data.contact
        shopNameLabel.text = data.shopName
        detailsLabel.text = "\(data.address), \(data.contact)"
    }
    
    @IBAction func logoutButtonPressed(_ sender: Any) {
        do {
          try Auth.auth().signOut()
        }
        catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
        
        self.view.window?.rootViewController = self.storyboard?.instantiateViewController(identifier: "SignIn") as? SigninViewController
        self.view.window?.makeKeyAndVisible()
    }
    
    func parseJSON(fileName: String) -> UserInfo {
        if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let url = documentDirectory.appendingPathComponent("\(fileName).json")
            print(url)
            
            var result: UserInfo?
            do {
                let jsonData = try Data(contentsOf: url)
                result = try JSONDecoder().decode(UserInfo.self, from: jsonData)
                
                if let result = result {
                    return result
                }
                else {
                    print("Parsing failed")
                }
            }
            catch {
                print("Error: \(error)")
            }
        }
        return UserInfo(shopName: "Shop name", details: "Details", address: "Address", contact: "Contact")
    }
    
}

struct UserInfo: Codable {
    var shopName: String
    var details: String
    var address: String
    var contact: String
}
