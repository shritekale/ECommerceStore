//
//  AddToCartResponseTests.swift
//  ECommerceStoreAPITests
//
//  Created by Shrikantreddy Tekale on 01/04/2020.
//  Copyright © 2020 Shrikantreddy Tekale. All rights reserved.
//

import XCTest
import Nimble
import Fetch

@testable import ECommerceStoreAPI

class DeleteFromCartResponseTests: XCTestCase {
  
  var request: DeleteFromCartRequest!
  
  override func setUp() {
    self.request = DeleteFromCartRequest(cartId: "test")
  }
  
  override func tearDown() {
    self.request = nil
  }

  func testResponseToDeleteFromCartIsParsedCorrectlyWhenItemIsDeleted() {
    let path = Bundle(for: DeleteFromCartResponseTests.self).path(forResource: "DeleteFromCartSuccessResponse", ofType: "json")
    let result = getParseResult(status: 204, testFilePath: path)
    switch result {
    case .success(let response):
      expect(response.message).to(equal("Product deleted from cart"))

    case .failure(_):
      fail()
    }
  }
  
  func testResponseToAddToCartIsParsedCorrectlyWhenItemIsNotAdded() {
    let path = Bundle(for: DeleteFromCartResponseTests.self).path(forResource: "DeleteFromCartProductNotInStockResponse", ofType: "json")
    let result = getParseResult(status: 404, testFilePath: path)
    switch result {
    case .success(let response):
      expect(response.message).to(equal("Cart item not found"))

    case .failure(_):
      fail()
    }
  }
  
  private func getParseResult(status:Int, testFilePath:String?) -> FetchResult<DeleteFromCartResponse> {
    let data = try! Data(contentsOf: URL(fileURLWithPath: testFilePath!), options: .mappedIfSafe)
    let testResponse = Response(data: data, status: status, headers: nil, userInfo: nil, originalRequest: request)
    return DeleteFromCartResponse.parse(response: testResponse, errorParser: nil)
  }

}
