//
//  ProductModel.swift
//  TaliKhata
//
//  Created by Rakibul Haque on 11/6/21.
//

class ProductModel{
    var productName: String?
    var quantity: String?
    var actualPrice: String?
    var sellingPrice: String?
    init(productName: String? , quantity: String? , actualPrice: String? , sellingPrice: String?){
        self.productName = productName;
        self.quantity = quantity;
        self.actualPrice = actualPrice;
        self.sellingPrice = sellingPrice;
    }
}
