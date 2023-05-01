//
//  Product.swift
//  TaliKhata
//
//  Created by Rakibul Haque on 11/4/21.
//

import Foundation

class Product {
    var name: String
    var remainingQuantity: Int
    var actualPrice: Double
    var sellingPrice: Double
    
    init(name: String, remainingQuantity: Int, actualPrice: Double, sellingPrice: Double) {
        self.name = name
        self.remainingQuantity = remainingQuantity
        self.actualPrice = actualPrice
        self.sellingPrice = sellingPrice
    }
}
