//
//  AddToCartRequestTests.swift
//  ECommerceStoreAPITests
//
//  Created by Shrikantreddy Tekale on 01/04/2020.
//  Copyright © 2020 Shrikantreddy Tekale. All rights reserved.
//

import XCTest
import Nimble
import Fetch

@testable import ECommerceStoreAPI

class DeleteFromCartRequestTests: XCTestCase {
  
  override func setUp() {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func testRequestToDeleteProductFromCartIsConfiguredCorrectly() {
    let request = DeleteFromCartRequest(cartId: "test")
    expect(request.url.absoluteString).to(equal("https://2klqdzs603.execute-api.eu-west-2.amazonaws.com/cloths/cart?id=test"))
    expect(request.body).to(beNil())
    let apiKey = request.headers!["X-API-KEY"]
    expect(apiKey).to(equal("DD95261772-4FC1-470B-ADE8-2E5D798E3172"))
  }
  
}
