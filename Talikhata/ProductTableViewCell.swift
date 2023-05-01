//
//  ProductTableViewCell.swift
//  TaliKhata
//
//  Created by Rakibul Haque on 11/4/21.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var remainingQuantityLabel: UILabel!
    @IBOutlet weak var actualPriceLabel: UILabel!
    @IBOutlet weak var sellingPriceLabel: UILabel!
    
    func setProduct(product: Product) {
        productNameLabel.text = product.name
        remainingQuantityLabel.text = "Remaining quantity: \(product.remainingQuantity) units"
        actualPriceLabel.text = "Actual price: \(product.actualPrice) ৳"
        sellingPriceLabel.text = "Selling price: \(product.sellingPrice) ৳"
    }
}
