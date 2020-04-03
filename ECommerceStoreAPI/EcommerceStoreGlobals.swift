//
//  EcommerceStoreGlobals.swift
//  ECommerceStoreAPI
//
//  Created by Shrikantreddy Tekale on 02/04/2020.
//  Copyright © 2020 Shrikantreddy Tekale. All rights reserved.
//

import Foundation

struct EcommerceStoreGlobals {
  static let apiUrl = "https://2klqdzs603.execute-api.eu-west-2.amazonaws.com" // TODO: construct this from NSURLComponents
  static let apiProductsPath = "cloths/products"
  static let apiCartPath = "cloths/cart"
  static let apiKey = "DD95261772-4FC1-470B-ADE8-2E5D798E3172" // TODO: Encrypt
}
