//
//  CartViewModel.swift
//  ECommerceStore
//
//  Created by Shrikantreddy Tekale on 02/04/2020.
//  Copyright © 2020 Shrikantreddy Tekale. All rights reserved.
//

import Foundation
import ECommerceStoreAPI

struct CartViewModel: CartRepresentable {
  let productId: Int
  let productName: String
  let productCategory: String
  let productCartId: Int
  
  init(product: Product, cartId: Int) {
    productId = product.id
    productName = product.name
    productCategory = product.category
    productCartId = cartId
  }
}
