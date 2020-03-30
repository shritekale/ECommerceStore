//
//  ECommerceStoreAPI.swift
//  ECommerceStoreAPI
//
//  Created by Shrikantreddy Tekale on 30/03/2020.
//  Copyright © 2020 Shrikantreddy Tekale. All rights reserved.
//

import Foundation
import Fetch

public class ECommerceStoreAPIRequests {
  
  static let session = Session()
  
  public static func fetchProducts() {
    let request = ProductRequest()
    session.perform(request) { (result: FetchResult<ProductResponse>) in
        switch result {
        case .success(let response):
            response.products.forEach { product in
                print("\(product.name)")
            }
        case .failure(let error):
            print("\(error)")
        }
    }
  }
}
