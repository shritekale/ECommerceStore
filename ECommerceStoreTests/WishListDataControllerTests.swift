//
//  WishListDataControllerTests.swift
//  ECommerceStoreTests
//
//  Created by Shrikantreddy Tekale on 02/04/2020.
//  Copyright © 2020 Shrikantreddy Tekale. All rights reserved.
//

import XCTest
import Nimble
import CoreData
import ECommerceStoreAPI

@testable import ECommerceStore

class WishListDataControllerTests: XCTestCase {
  
  var wishListDataController: WishListDataController!
  
  lazy var managedObjectModel: NSManagedObjectModel = {
    let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle(for: type(of: self))] )!
    return managedObjectModel
  }()
  
  lazy var mockPersistantContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "ECommerceStore", managedObjectModel: self.managedObjectModel)
    let description = NSPersistentStoreDescription()
    description.type = NSInMemoryStoreType
    description.shouldAddStoreAsynchronously = false // Make it simpler in test env
    
    container.persistentStoreDescriptions = [description]
    container.loadPersistentStores { (description, error) in
      precondition( description.type == NSInMemoryStoreType )
      
      if let error = error {
        fatalError("Create an in-mem coordinator failed \(error)")
      }
    }
    return container
  }()
  
  override func setUp() {
    super.setUp()
    wishListDataController = WishListDataController(container: mockPersistantContainer)
  }
  
  override func tearDown() {
  }
  
  func testSingleItemsIsAddedAndRemovedFromWishlistCorrectly() {
      let mockProduct = MockProduct(productId: 1, productName: "testName1", productCategory: "testCategory1")
      do {
        try wishListDataController.addProductToWishlist(viewModel: mockProduct)
        var wishListProduct = try wishListDataController.getWishlistProduct(withId: 1)
        expect(wishListProduct?.count).to(equal(1))
        
        guard let product = wishListProduct?[0] else {
          fail()
          return
        }
        
        expect(product.id).to(equal(1))
        expect(product.name).to(equal("testName1"))
        expect(product.category).to(equal("testCategory1"))
        
        try wishListDataController.removeProductFromWishlist(viewModel: mockProduct)
        wishListProduct = try wishListDataController.getWishlistProduct(withId: 1)
        expect(wishListProduct?.count).to(equal(0))
      } catch  {
        fail()
      }
  }
  
  func testAllTheItemsAreFetchedAndRemovedFromWishlistCorrectly() {
    let mockProduct1 = MockProduct(productId: 1, productName: "testName1", productCategory: "testCategory1")
    let mockProduct2 = MockProduct(productId: 2, productName: "testName1", productCategory: "testCategory1")
    let mockProduct3 = MockProduct(productId: 3, productName: "testName1", productCategory: "testCategory1")

      do {
        try wishListDataController.addProductToWishlist(viewModel: mockProduct1)
        try wishListDataController.addProductToWishlist(viewModel: mockProduct2)
        try wishListDataController.addProductToWishlist(viewModel: mockProduct3)

        var wishListProduct = try wishListDataController.getWishlist()
        expect(wishListProduct?.count).to(equal(3))
                
        try wishListDataController.removeAllProductsFromWishlist()
        
        wishListProduct = try wishListDataController.getWishlist()
        expect(wishListProduct?.count).to(equal(0))
      } catch  {
        fail()
      }
  }

}


struct MockProduct: ProductRepresentable {
  let productId: Int
  let productName: String
  let productCategory: String
  let productPrice: String = ""
  let productOldPrice: String = ""
  let productStock: Int = 0
  
  init(productId: Int, productName: String, productCategory: String) {
    self.productId = productId
    self.productName = productName
    self.productCategory = productCategory
  }
}

