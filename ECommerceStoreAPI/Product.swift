//
//  Product.swift
//  ECommerceStoreAPI
//
//  Created by Shrikantreddy Tekale on 29/03/2020.
//  Copyright © 2020 Shrikantreddy Tekale. All rights reserved.
//

import Foundation

struct Product: Decodable {
  let id: Int
  let name: String
  let category: String
  let price: String
  let oldPrice: String?
  let stock: Int
}
