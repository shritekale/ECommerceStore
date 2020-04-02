//
//  ProductResponse.swift
//  ECommerceStoreAPI
//
//  Created by Shrikantreddy Tekale on 30/03/2020.
//  Copyright © 2020 Shrikantreddy Tekale. All rights reserved.
//

import Foundation
import Fetch

public struct CartResponse {
  public let cartItems: [CartItem]
}

extension CartResponse: Parsable {
  public static func parse(response: Response, errorParser: ErrorParsing.Type?) -> FetchResult<CartResponse> {
    if response.status != 200 {
      if let error = errorParser?.parseError(from: response.data, statusCode: response.status) {
        return .failure(error)
      } else {
        return .failure(ProductParseError.non200Response)
      }
    }
    do {
      if let data = response.data {
        let cartItems: [CartItem] = try JSONDecoder().decode([CartItem].self, from: data)
        return .success(CartResponse(cartItems: cartItems))
      }
    } catch {}
    return .failure(CartParseError.parseFailure)
  }
}

enum CartParseError: Error, ErrorParsing {
  case non200Response
  case parseFailure
  
  static func parseError(from: Data?, statusCode: Int) -> Error? {
    if statusCode != 200 {
      return ProductParseError.non200Response
    }
    
    return nil
  }
}
