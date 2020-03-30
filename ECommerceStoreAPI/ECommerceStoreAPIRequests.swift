//
//  ECommerceStoreAPI.swift
//  ECommerceStoreAPI
//
//  Created by Shrikantreddy Tekale on 30/03/2020.
//  Copyright © 2020 Shrikantreddy Tekale. All rights reserved.
//

import Foundation
import Fetch

public typealias ProductResult<ProductResponse> = Result<ProductResponse, Error>

public class ECommerceStoreAPIRequests {
  
  public static func fetchProducts(completion: @escaping (ProductResult<ProductResponse>) -> Void) {
    let session = Session()
    let request = ProductRequest()
    session.perform(request) { (result: FetchResult<ProductResponse>) in
      switch result {
      case .success(let response):
        completion(.success(response))
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
  
}
