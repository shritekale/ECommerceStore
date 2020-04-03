//
//  AddToCartRequest.swift
//  ECommerceStoreAPI
//
//  Created by Shrikantreddy Tekale on 01/04/2020.
//  Copyright © 2020 Shrikantreddy Tekale. All rights reserved.
//

import Foundation
import Fetch

struct DeleteFromCartRequest: Request {
  var url: URL
  let method = HTTPMethod.delete
  let headers: [String: String]? = ["X-API-KEY": EcommerceStoreGlobals.apiKey]
  let body: Data? = nil
  
  init(cartId: String) {
    let queryItem = URLQueryItem(name: "id", value: cartId)
    url = URL(string: "\(EcommerceStoreGlobals.apiUrl)/\(EcommerceStoreGlobals.apiCartPath)")!
    url = url.appending(queryItems: [queryItem])
  }
}
