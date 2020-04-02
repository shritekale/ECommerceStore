//
//  WishListRepresentable.swift
//  ECommerceStore
//
//  Created by Shrikantreddy Tekale on 02/04/2020.
//  Copyright © 2020 Shrikantreddy Tekale. All rights reserved.
//

import UIKit

struct WishListViewModel: WishListRepresentable {
  let productId: Int
  let productName: String
  let productCategory: String
  
  init(product: WishlistProduct) {
    productId = Int(product.id)
    productName = product.name ?? ""
    productCategory = product.category ?? ""
  }
}
