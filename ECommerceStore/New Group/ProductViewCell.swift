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
  
  func updateCellWithProduct(_ product: Product) {
    nameLabel.text = product.name
    categoryLabel.text = product.category
    priceLabel.text = product.price
    quantityLabel.text = String(product.stock)
    
    let stock = product.oldPrice ?? ""
    oldPriceLabel.attributedText = stock.strikeThrough()
  }
  
}
