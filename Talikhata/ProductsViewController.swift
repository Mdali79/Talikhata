//
//  ProductsViewController.swift
//  TaliKhata
//
//  Created by Rakibul Haque on 11/4/21.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth


class ProductsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var productsTable: UITableView!
    
    var products: [Product] = []
    var ref = DatabaseReference.init()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell") as! ProductTableViewCell
        cell.setProduct(product: self.products[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        tableView.beginUpdates()
        self.products.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
        tableView.endUpdates()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userId = Auth.auth().currentUser!.uid
        
        self.ref = Database.database().reference().child(userId)
        self.ref.observe(DataEventType.value, with: { (snapshot) in
            if snapshot.childrenCount > 0 {
                self.products.removeAll()
                
                for object in snapshot.children.allObjects as! [DataSnapshot] {
                    let product = object.value as? [String: AnyObject]
                    let product_ = Product(name: product?["name"] as! String, remainingQuantity: Int(product?["quantity"] as! String)!, actualPrice: Double(product?["actual_price"] as! String)!, sellingPrice: Double(product?["selling_price"] as! String)!)
                    self.products.append(product_)
                }
                
                self.productsTable.reloadData()
            }
        })
    }
}
