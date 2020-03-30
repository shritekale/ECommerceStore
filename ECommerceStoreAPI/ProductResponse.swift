//
//  ProductResponse.swift
//  ECommerceStoreAPI
//
//  Created by Shrikantreddy Tekale on 30/03/2020.
//  Copyright © 2020 Shrikantreddy Tekale. All rights reserved.
//

import Foundation
import Fetch

struct ProductResponse {
  let products: [Product]
}

extension ProductResponse: Parsable {
  static func parse(response: Response, errorParser: ErrorParsing.Type?) -> FetchResult<ProductResponse> {
    if response.status != 200 {
      if let error = errorParser?.parseError(from: response.data, statusCode: response.status) {
        return .failure(error)
      } else {
        return .failure(ProductParseError.non200Response)
      }
    }
    do {
      if let data = response.data {
        let products: [Product] = try JSONDecoder().decode([Product].self, from: data)
        return .success(ProductResponse(products: products))
      }
    } catch {}
    return .failure(ProductParseError.parseFailure)
  }
}

enum ProductParseError: Error, ErrorParsing {
  case non200Response
  case parseFailure
  
  static func parseError(from: Data?, statusCode: Int) -> Error? {
    if statusCode != 200 {
      return ProductParseError.non200Response
    }
    return nil
  }
}
