//
//  AddToCartResponse.swift
//  ECommerceStoreAPI
//
//  Created by Shrikantreddy Tekale on 01/04/2020.
//  Copyright © 2020 Shrikantreddy Tekale. All rights reserved.
//

import Foundation
import Fetch

public struct DeleteFromCartResponse: Decodable {
  public let message: String
}

struct DeleteFromHandledStatus {
  let code:[Int] = [401, 404]
}

extension DeleteFromCartResponse: Parsable {
  public static func parse(response: Response, errorParser: ErrorParsing.Type?) -> FetchResult<DeleteFromCartResponse> {
    
    if response.status == 204 {
      return .success(DeleteFromCartResponse(message: "Product deleted from cart"))
    }
    
    if !DeleteFromHandledStatus().code.contains(response.status) {
      if let error = errorParser?.parseError(from: response.data, statusCode: response.status) {
        return .failure(error)
      } else {
        return .failure(DeleteFromCartResponseError.nonHandledResponse)
      }
    }
    do {
      if let data = response.data {
        let dict: [String: String] = try JSONDecoder().decode([String: String].self, from: data)
        if let message = dict["message"] {
          return .success(DeleteFromCartResponse(message: message))
        } else {
          return .failure(DeleteFromCartResponseError.parseFailure)
        }
      }
    } catch {}
    return .failure(DeleteFromCartResponseError.parseFailure)
  }
}

enum DeleteFromCartResponseError: Error, ErrorParsing {
  case nonHandledResponse
  case parseFailure

  static func parseError(from: Data?, statusCode: Int) -> Error? {
    if !AddToCartHandledStatus().code.contains(statusCode) {
      return AddToCartError.nonHandledResponse
    }
    
    return nil
  }
}
