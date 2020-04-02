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

class GetCartResponseTests: XCTestCase {
  
  var request: CartRequest!
  
  override func setUp() {
    self.request = CartRequest()
  }
  
  override func tearDown() {
    self.request = nil
  }

  func testResponseToAddToCartIsParsedCorrectlyWhenItemIsAdded() {
    let path = Bundle(for: AddToCartResponseTests.self).path(forResource: "GetCartSuccessResponse", ofType: "json")
    let result = getParseResult(status: 200, testFilePath: path)
    switch result {
    case .success(let response):
      expect(response.cartItems.count).to(equal(6))
      expect(response.cartItems[0].id).to(equal(2))
      expect(response.cartItems[0].productId).to(equal(1))

    case .failure(_):
      fail()
    }
  }
  
  func testResponseToAddToCartIsParsedCorrectlyWhenItemIsNotAdded() {
    let path = Bundle(for: AddToCartResponseTests.self).path(forResource: "GetCartWithNoProductResponse", ofType: "json")
    let result = getParseResult(status: 200, testFilePath: path)
    switch result {
    case .success(let response):
      expect(response.cartItems.count).to(equal(0))

    case .failure(_):
      fail()
    }
  }
  
  func testResponseToAddToCartIsReturnsErrorWhenDataIsMissing() {
    let path = Bundle(for: AddToCartResponseTests.self).path(forResource: "GetCartMissingDataResponse", ofType: "json")
    let result = getParseResult(status: 200, testFilePath: path)
    switch result {
    case .success(_):
      fail()

    case .failure(let error):
      expect(error).toNot(beNil())
    }
  }

  
  private func getParseResult(status:Int, testFilePath:String?) -> FetchResult<CartResponse> {
    let data = try! Data(contentsOf: URL(fileURLWithPath: testFilePath!), options: .mappedIfSafe)
    let testResponse = Response(data: data, status: status, headers: nil, userInfo: nil, originalRequest: request)
    return CartResponse.parse(response: testResponse, errorParser: nil)
  }

}
