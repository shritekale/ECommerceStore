//
//  ProductListDataSourceTests.swift
//  ECommerceStoreTests
//
//  Created by Shrikantreddy Tekale on 31/03/2020.
//  Copyright © 2020 Shrikantreddy Tekale. All rights reserved.
//

import XCTest
import Nimble
import ECommerceStoreAPI

@testable import ECommerceStore

class ProductListDataSourceTests: XCTestCase {
  
    
  func testProductsAreLoadedCorrectly() {
    let products = TestProducts.getProducts()
    expect(products.count).to(equal(2))
  }
  
  func testDataSourceReturnsCorrectNumberOfCells() {
    let mockViewCellDelegatge = MockViewCellDelegate()
    let productListDataSource = ProductListDataSource(viewCellDelegate: mockViewCellDelegatge)
    let tableView = UITableView()
    let numberOfCellsBeforeUpdate = productListDataSource.tableView(tableView, numberOfRowsInSection: 0)
    expect(numberOfCellsBeforeUpdate).to(equal(0))

    productListDataSource.products = TestProducts.getProducts()
    let numberOfCellsAfterUpdate = productListDataSource.tableView(tableView, numberOfRowsInSection: 0)
    expect(numberOfCellsAfterUpdate).to(equal(2))
  }

}

class MockViewCellDelegate: ProductViewCellProtocol {
  func addProductToCart(_ product: Product) {}
  func addProductToWishList(_ product: Product) {}
}
