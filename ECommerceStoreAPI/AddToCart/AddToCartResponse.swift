//
//  AddToCartResponse.swift
//  ECommerceStoreAPI
//
//  Created by Shrikantreddy Tekale on 01/04/2020.
//  Copyright © 2020 Shrikantreddy Tekale. All rights reserved.
//

import Foundation
import Fetch


public struct AddToCartResponse: Decodable {
  public let message: String
}

struct AddToCartHandledStatus {
  let code:[Int] = [201, 401, 403, 404]
}

extension AddToCartResponse: Parsable {
  public static func parse(response: Response, errorParser: ErrorParsing.Type?) -> FetchResult<AddToCartResponse> {
    if !AddToCartHandledStatus().code.contains(response.status) {
      if let error = errorParser?.parseError(from: response.data, statusCode: response.status) {
        return .failure(error)
      } else {
        return .failure(AddToCartError.nonHandledResponse)
      }
    }
    do {
      if let data = response.data {
        let dict: [String: String] = try JSONDecoder().decode([String: String].self, from: data)
        if let message = dict["message"] {
          return .success(AddToCartResponse(message: message))
        } else {
          return .failure(AddToCartError.parseFailure)
        }
      }
    } catch {}
    return .failure(AddToCartError.parseFailure)
  }
}

enum AddToCartError: Error, ErrorParsing {
  case nonHandledResponse
  case parseFailure

  static func parseError(from: Data?, statusCode: Int) -> Error? {
    if !AddToCartHandledStatus().code.contains(statusCode) {
      return AddToCartError.nonHandledResponse
    }
    
    return nil
  }
}
