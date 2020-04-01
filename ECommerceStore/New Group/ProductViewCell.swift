//
//  ProductViewCell.swift
//  ECommerceStore
//
//  Created by Shrikantreddy Tekale on 31/03/2020.
//  Copyright © 2020 Shrikantreddy Tekale. All rights reserved.
//

import UIKit
import ECommerceStoreAPI

class ProductViewCell: UITableViewCell {
  
  @IBOutlet private weak var nameLabel: UILabel!
  @IBOutlet private weak var categoryLabel: UILabel!
  @IBOutlet private weak var priceLabel: UILabel!
  @IBOutlet private weak var oldPriceLabel: UILabel!
  @IBOutlet private weak var quantityLabel: UILabel!
  
  var delegate: ProductViewCellProtocol?
  
  private var product: Product?
  
  func updateCellWithProduct(_ product: Product) {
    self.product = product
    nameLabel.text = product.name
    categoryLabel.text = product.category
    priceLabel.text = product.price
    quantityLabel.text = String(product.stock)
    
    let stock = product.oldPrice ?? ""
    oldPriceLabel.attributedText = stock.strikeThrough()
  }
  
  @IBAction func addToCartPressed() {
    guard let product = product else {
      return
    }
    
    delegate?.addProductToCart(product)
  }
  
  @IBAction func addToWishlistPressed() {
    guard let product = product else {
      return
    }
    
    delegate?.addProductToWishList(product)
  }

}

protocol ProductViewCellProtocol {
  func addProductToCart(_ product: Product)
  func addProductToWishList(_ product: Product)
}
