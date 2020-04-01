//
//  ProductResponseTests.swift
//  ECommerceStoreAPITests
//
//  Created by Shrikantreddy Tekale on 01/04/2020.
//  Copyright © 2020 Shrikantreddy Tekale. All rights reserved.
//

import XCTest
import Nimble
import Fetch

@testable import ECommerceStoreAPI

class ProductResponseTests: XCTestCase {
  
  var request: ProductRequest!
  
  override func setUp() {
    self.request = ProductRequest()
  }
  
  override func tearDown() {
    self.request = nil
  }
  
  func testResponseToGetProductsIsParsedCorrectlyWhenProductsAreReturned() {
    let path = Bundle(for: ProductResponseTests.self).path(forResource: "GetProductSuccessResponse", ofType: "json")
    let result = getParseResult(testFilePath: path)
    switch result {
    case .success(let response):
      expect(response.products.count).to(equal(13))
      expect(response.products[0].id).to(equal(1))
      expect(response.products[0].name).to(equal("Almond Toe Court Shoes, Patent Black"))
      expect(response.products[0].category).to(equal("Women’s Footwear"))
      expect(response.products[0].price).to(equal("99.00"))
      expect(response.products[0].oldPrice).to(beNil())
      expect(response.products[0].stock).to(equal(5))

    case .failure(_):
      fail()
    }
  }
  
  func testResponseToGetProductsIsParsedCorrectlyWhenNoProductsAreReturned() {
    let path = Bundle(for: ProductResponseTests.self).path(forResource: "GetProductSuccessResponseNoProducts", ofType: "json")
    let result = getParseResult(testFilePath: path)
    switch result {
    case .success(let response):
      expect(response.products.count).to(equal(0))

    case .failure(_):
      fail()
    }
  }
  
  func testResponseToGetProductsReturnsErrorWhenParsingFails() {
    let path = Bundle(for: ProductResponseTests.self).path(forResource: "GetProductSuccessResponseMissingData", ofType: "json")
    let result = getParseResult(testFilePath: path)
    switch result {
    case .success(_):
      fail()

    case .failure(let error):
      expect(error).toNot(beNil())
    }
  }
    
  private func getParseResult(testFilePath:String?) -> FetchResult<ProductResponse> {
    let data = try! Data(contentsOf: URL(fileURLWithPath: testFilePath!), options: .mappedIfSafe)
    let testResponse = Response(data: data, status: 200, headers: nil, userInfo: nil, originalRequest: request)
    return ProductResponse.parse(response: testResponse, errorParser: nil)
  }

}
