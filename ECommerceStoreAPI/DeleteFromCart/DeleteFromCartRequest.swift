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
  let headers: [String: String]? = ["X-API-KEY": "DD95261772-4FC1-470B-ADE8-2E5D798E3172"]
  let body: Data? = nil
  
  init(cartId: String) {
    let queryItem = URLQueryItem(name: "id", value: cartId)
    url = URL(string: "https://2klqdzs603.execute-api.eu-west-2.amazonaws.com/cloths/cart")!
    url = url.appending(queryItems: [queryItem])
  }
}
