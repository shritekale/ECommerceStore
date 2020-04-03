//
//  ProductRequest.swift
//  ECommerceStoreAPI
//
//  Created by Shrikantreddy Tekale on 30/03/2020.
//  Copyright © 2020 Shrikantreddy Tekale. All rights reserved.
//

import Foundation
import Fetch

struct ProductRequest: Request {
  let url = URL(string: "\(EcommerceStoreGlobals.apiUrl)/\(EcommerceStoreGlobals.apiProductsPath)")! // TODO: Construct from NSURLComponents
  let method = HTTPMethod.get
  let headers: [String: String]? = ["X-API-KEY": EcommerceStoreGlobals.apiKey]
  let body: Data? = nil
}
