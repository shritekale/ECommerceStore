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

class AddToCartResponseTests: XCTestCase {
  
  var request: AddToCartRequest!
  
  override func setUp() {
    self.request = AddToCartRequest(productId: "test")
  }
  
  override func tearDown() {
    self.request = nil
  }

  func testResponseToAddToCartIsParsedCorrectlyWhenItemIsAdded() {
    let path = Bundle(for: AddToCartResponseTests.self).path(forResource: "AddToCartSuccessResponse", ofType: "json")
    let result = getParseResult(status: 201, testFilePath: path)
    switch result {
    case .success(let response):
      expect(response.message).to(equal("Product added to cart"))

    case .failure(_):
      fail()
    }
  }
  
  func testResponseToAddToCartIsParsedCorrectlyWhenItemIsNotAdded() {
    let path = Bundle(for: AddToCartResponseTests.self).path(forResource: "AddToCartProductNotInStockResponse", ofType: "json")
    let result = getParseResult(status: 403, testFilePath: path)
    switch result {
    case .success(let response):
      expect(response.message).to(equal("Product not in stock"))

    case .failure(_):
      fail()
    }
  }
  
  func testResponseToAddToCartIsReturnsErrorWhenDataIsMissing() {
    let path = Bundle(for: AddToCartResponseTests.self).path(forResource: "AddToCartMissingDataResponse", ofType: "json")
    let result = getParseResult(status: 403, testFilePath: path)
    switch result {
    case .success(_):
      fail()

    case .failure(let error):
      expect(error).toNot(beNil())
    }
  }

  
  private func getParseResult(status:Int, testFilePath:String?) -> FetchResult<AddToCartResponse> {
    let data = try! Data(contentsOf: URL(fileURLWithPath: testFilePath!), options: .mappedIfSafe)
    let testResponse = Response(data: data, status: status, headers: nil, userInfo: nil, originalRequest: request)
    return AddToCartResponse.parse(response: testResponse, errorParser: nil)
  }

}
