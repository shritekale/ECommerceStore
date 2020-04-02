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
public typealias AddToCartResult<AddToCartResponse> = Result<AddToCartResponse, Error>
public typealias GetCartResult<CartResponse> = Result<CartResponse, Error>

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
  
  public static func addProductToCart(productId:Int, completion: @escaping (AddToCartResult<AddToCartResponse>) -> Void) {
    let session = Session()
    let request = AddToCartRequest(productId: String(productId))
    session.perform(request) { (result: FetchResult<AddToCartResponse>) in
      switch result {
      case .success(let response):
        completion(.success(response))
      case .failure(let error):
        completion(.failure(error))
      }
    }

  }
  
  public static func fetchCart(completion: @escaping (GetCartResult<CartResponse>) -> Void) {
    let session = Session()
    let request = CartRequest()
    session.perform(request) { (result: FetchResult<CartResponse>) in
      switch result {
      case .success(let response):
        completion(.success(response))
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }

  
}
