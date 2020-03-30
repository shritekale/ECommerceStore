//
//  Product.swift
//  ECommerceStoreAPI
//
//  Created by Shrikantreddy Tekale on 29/03/2020.
//  Copyright © 2020 Shrikantreddy Tekale. All rights reserved.
//

import Foundation

public struct Product: Decodable {
  public let id: Int
  public let name: String
  public let category: String
  public let price: String
  public let oldPrice: String?
  public let stock: Int
}
