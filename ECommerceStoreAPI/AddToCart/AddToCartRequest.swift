//
//  AddToCartRequest.swift
//  ECommerceStoreAPI
//
//  Created by Shrikantreddy Tekale on 01/04/2020.
//  Copyright © 2020 Shrikantreddy Tekale. All rights reserved.
//

import Foundation
import Fetch

struct AddToCartRequest: Request {
  var url: URL
  let method = HTTPMethod.post
  let headers: [String: String]? = ["X-API-KEY": EcommerceStoreGlobals.apiKey]
  let body: Data? = nil
  
  init(productId: String) {
    let queryItem = URLQueryItem(name: "productId", value: productId)
    url = URL(string: "\(EcommerceStoreGlobals.apiUrl)/\(EcommerceStoreGlobals.apiCartPath)")!
    url = url.appending(queryItems: [queryItem])
  }
}
