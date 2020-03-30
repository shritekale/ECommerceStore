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
  
  override func setUp() {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func testRequestToGetProductsIsConfiguredCorrectly() {
    let request = ProductRequest()
    expect(request.url.absoluteString).to(equal("https://2klqdzs603.execute-api.eu-west-2.amazonaws.com/cloths/products"))
    expect(request.body).to(beNil())
    
    let apiKey = request.headers!["X-API-KEY"]
    expect(apiKey).to(equal("DD95261772-4FC1-470B-ADE8-2E5D798E3172"))
  }
  
  func testResponseToGetProductsIsParsedCorrectlyWhenProductsAreReturned() {
    let request = ProductRequest()
    let path = Bundle(for: ProductTests.self).path(forResource: "GetProductSuccessResponse", ofType: "json")
    let data = try! Data(contentsOf: URL(fileURLWithPath: path!), options: .mappedIfSafe)
    let testResponse = Response(data: data, status: 200, headers: nil, userInfo: nil, originalRequest: request)
    
    let result = ProductResponse.parse(response: testResponse, errorParser: nil)
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
    let request = ProductRequest()
    let path = Bundle(for: ProductTests.self).path(forResource: "GetProductSuccessResponseNoProducts", ofType: "json")
    let data = try! Data(contentsOf: URL(fileURLWithPath: path!), options: .mappedIfSafe)
    let testResponse = Response(data: data, status: 200, headers: nil, userInfo: nil, originalRequest: request)
    
    let result = ProductResponse.parse(response: testResponse, errorParser: nil)
    switch result {
    case .success(let response):
      expect(response.products.count).to(equal(0))

    case .failure(_):
      fail()
    }
  }
  
  func testResponseToGetProductsReturnsErrorWhenParsingFails() {
    let request = ProductRequest()
    let path = Bundle(for: ProductTests.self).path(forResource: "GetProductSuccessResponseMissingData", ofType: "json")
    let data = try! Data(contentsOf: URL(fileURLWithPath: path!), options: .mappedIfSafe)
    let testResponse = Response(data: data, status: 200, headers: nil, userInfo: nil, originalRequest: request)
    
    let result = ProductResponse.parse(response: testResponse, errorParser: nil)
    switch result {
    case .success(_):
      fail()

    case .failure(let error):
      expect(error).toNot(beNil())
    }
  }


}
