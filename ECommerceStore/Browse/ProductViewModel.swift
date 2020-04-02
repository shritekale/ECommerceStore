//
//  ProductRepresentable.swift
//  ECommerceStore
//
//  Created by Shrikantreddy Tekale on 02/04/2020.
//  Copyright © 2020 Shrikantreddy Tekale. All rights reserved.
//

import UIKit
import ECommerceStoreAPI

struct ProductViewModel: ProductRepresentable {
  let productId: Int
  let productName: String
  let productCategory: String
  let productPrice: String
  let productOldPrice: String
  let productStock: Int
  
  init(product: Product) {
    productId = product.id
    productName = product.name
    productCategory = product.category
    productPrice = product.price
    productOldPrice = product.oldPrice ?? ""
    productStock = product.stock
  }
}
