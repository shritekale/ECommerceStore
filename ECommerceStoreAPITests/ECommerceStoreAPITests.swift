//
//  ECommerceStoreAPITests.swift
//  ECommerceStoreAPITests
//
//  Created by Shrikantreddy Tekale on 29/03/2020.
//  Copyright © 2020 Shrikantreddy Tekale. All rights reserved.
//

import XCTest
import Nimble
import Fetch

@testable import ECommerceStoreAPI

class ProductTests: XCTestCase {
  
  let request = ProductRequest()

  override func setUp() {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func testRequestToGetProductsIsConfiguredCorrectly() {
    expect(self.request.url.absoluteString).to(equal("https://2klqdzs603.execute-api.eu-west-2.amazonaws.com/cloths/products"))
    expect(self.request.body).to(beNil())
    
    let apiKey = request.headers!["X-API-KEY"]
    expect(apiKey).to(equal("DD95261772-4FC1-470B-ADE8-2E5D798E3172"))
  }
  
  func testResponseToGetProductsIsParsedCorrectlyWhenProductsAreReturned() {
    let path = Bundle(for: ProductTests.self).path(forResource: "GetProductSuccessResponse", ofType: "json")
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
    let path = Bundle(for: ProductTests.self).path(forResource: "GetProductSuccessResponseNoProducts", ofType: "json")
    let result = getParseResult(testFilePath: path)
    switch result {
    case .success(let response):
      expect(response.products.count).to(equal(0))

    case .failure(_):
      fail()
    }
  }
  
  func testResponseToGetProductsReturnsErrorWhenParsingFails() {
    let path = Bundle(for: ProductTests.self).path(forResource: "GetProductSuccessResponseMissingData", ofType: "json")
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
