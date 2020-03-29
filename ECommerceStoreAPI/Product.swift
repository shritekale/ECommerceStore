//
//  Product.swift
//  ECommerceStoreAPI
//
//  Created by Shrikantreddy Tekale on 29/03/2020.
//  Copyright © 2020 Shrikantreddy Tekale. All rights reserved.
//

import Foundation
import Fetch

struct Product {
  let id: Int
  let name: String
  let category: String
  let price: String
  let oldPrice: String
  let stock: Int
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
            if let data = response.data, let parsedResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: AnyObject]] {
                let products = parsedResponse.map { prod -> Product in
                  let identifier = prod["id"] as! Int
                  let name = prod["name"] as! String
                  let category = prod["category"] as! String
                  let price = prod["price"] as! String
                  let oldPrice = prod["oldPrice"] as! String
                  let stock = prod["stock"] as! Int
                  return Product(id: identifier, name: name, category: category, price: price, oldPrice: oldPrice, stock: stock)
                }
                return .success(ProductResponse(products: products))
            }
        } catch {}
        return .failure(ProductParseError.parseFailure)
    }
}

