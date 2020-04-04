//
//  ECommerceStoreUITests.swift
//  ECommerceStoreUITests
//
//  Created by Shrikantreddy Tekale on 29/03/2020.
//  Copyright © 2020 Shrikantreddy Tekale. All rights reserved.
//

import XCTest

class ECommerceStoreUITests: XCTestCase {
  
  override func setUp() {
    continueAfterFailure = false
  }
  
  override func tearDown() {
    let app = XCUIApplication()
    app.launch()
    let helper = ECommerceStoreHelper(app: app)
    helper.removeAllItemsFromWishList()
    helper.removeAllItemsFromCart()
  }
  
  // UserStory 1:
  // As a Customer I can view the products and their category, price, old price for discounted products and availability information.
  func testUserCanViewTheProductInformation() {
    let app = XCUIApplication()
    app.launch()
    wait(for: ECommerceStoreWaitTimes.medium.rawValue)
    
    let productCellIdentifier = ECommerceStoreIdentifiers.productCell
    let productName = app.tables.children(matching: .cell).matching(identifier: productCellIdentifier).firstMatch.staticTexts[ECommerceStoreIdentifiers.productName]
    let productCategory = app.tables.children(matching: .cell).matching(identifier: productCellIdentifier).firstMatch.staticTexts[ECommerceStoreIdentifiers.productCategory]
    let productPrice = app.tables.children(matching: .cell).matching(identifier: productCellIdentifier).firstMatch.staticTexts[ECommerceStoreIdentifiers.productPrice]
    let productOldPrice = app.tables.children(matching: .cell).matching(identifier: productCellIdentifier).firstMatch.staticTexts[ECommerceStoreIdentifiers.productOldPrice]
    let productQuantity = app.tables.children(matching: .cell).matching(identifier: productCellIdentifier).firstMatch.staticTexts[ECommerceStoreIdentifiers.productQuantity]
    
    XCTAssertTrue(productName.label == "Almond Toe Court Shoes, Patent Black")
    XCTAssertTrue(productCategory.label == "Women’s Footwear")
    XCTAssertTrue(productPrice.label == "99.00")
    XCTAssertTrue(productOldPrice.label == "")
    XCTAssertTrue(productQuantity.label == "5")
  }
  
  // UserStory 2:
  // As a Customer I can add a product to my shopping cart
  func testUserCanAddAndViewAProductInShoppingCart() {
    let app = XCUIApplication()
    app.launch()
    wait(for: ECommerceStoreWaitTimes.medium.rawValue)
    
    let button = app.tables.children(matching: .cell).matching(identifier: ECommerceStoreIdentifiers.productCell).firstMatch.buttons[ECommerceStoreIdentifiers.addToCartButton]
    button.tap()
    wait(for: ECommerceStoreWaitTimes.medium.rawValue)

    XCTAssertTrue(app.alerts.element.exists)
    
    app.alerts.scrollViews.otherElements.buttons[ECommerceStoreIdentifiers.okButton].tap()
    let productQuantity = app.tables.children(matching: .cell).matching(identifier: ECommerceStoreIdentifiers.productCell).firstMatch.staticTexts[ECommerceStoreIdentifiers.productQuantity]
    XCTAssertTrue(productQuantity.label == "4")
    
    app.tabBars.buttons[ECommerceStoreIdentifiers.cartButton].tap()
    
    let productName = app.tables.children(matching: .cell).matching(identifier: ECommerceStoreIdentifiers.cartTableViewCell).firstMatch.staticTexts[ECommerceStoreIdentifiers.productName]
    XCTAssertTrue(productName.label == "Almond Toe Court Shoes, Patent Black")
  }
  
  // UserStory 3:
  // As a Customer I can add a product to my wishlist
  func testUserCanAddAndViewAProductInMyWishlist() {
    let app = XCUIApplication()
    app.launch()
    wait(for: ECommerceStoreWaitTimes.medium.rawValue)
    
    let button = app.tables.children(matching: .cell).matching(identifier: ECommerceStoreIdentifiers.productCell).firstMatch.buttons[ECommerceStoreIdentifiers.addToWishlistButton]
    button.tap()
    
    XCTAssertTrue(app.alerts.element.exists)
    
    app.alerts.scrollViews.otherElements.buttons[ECommerceStoreIdentifiers.okButton].tap()
    app.tabBars.buttons[ECommerceStoreIdentifiers.wishListButton].tap()
    
    let productName = app.tables.children(matching: .cell).matching(identifier: ECommerceStoreIdentifiers.wishListTableViewCell).firstMatch.staticTexts[ECommerceStoreIdentifiers.productName]
    XCTAssertTrue(productName.label == "Almond Toe Court Shoes, Patent Black")
  }
  
  // UserStory 4:
  // As a Customer I can remove a product from my shopping cart
  func testUserCanRemoveProductInShoppingCart() {
    let app = XCUIApplication()
    app.launch()
    wait(for: ECommerceStoreWaitTimes.medium.rawValue)
    
    let button = app.tables.children(matching: .cell).matching(identifier: ECommerceStoreIdentifiers.productCell).firstMatch.buttons[ECommerceStoreIdentifiers.addToCartButton]
    button.tap()
    app.alerts.scrollViews.otherElements.buttons[ECommerceStoreIdentifiers.okButton].tap()
    app.tabBars.buttons[ECommerceStoreIdentifiers.cartButton].tap()
    
    let productName = app.tables.children(matching: .cell).matching(identifier: ECommerceStoreIdentifiers.cartTableViewCell).firstMatch.staticTexts[ECommerceStoreIdentifiers.productName]
    XCTAssertTrue(productName.label == "Almond Toe Court Shoes, Patent Black")

    let removeFromCartButton = app.tables.descendants(matching: .button).matching(identifier:ECommerceStoreIdentifiers.removeFromCartButton).firstMatch
    removeFromCartButton.tap()
    app.alerts.scrollViews.otherElements.buttons[ECommerceStoreIdentifiers.okButton].tap()

    let productNameAfterRemoval = app.tables.children(matching: .cell).matching(identifier: ECommerceStoreIdentifiers.cartTableViewCell).firstMatch.staticTexts[ECommerceStoreIdentifiers.productName]
    XCTAssertFalse(productNameAfterRemoval.exists)
  }
  
  // UserStory 6:
  // As a Customer I am unable to add Out of Stock products to the shopping cart
  func testUserCanNotAddProductWhichIsOutOfStockInShoppingCart() {
    let app = XCUIApplication()
    app.launch()
    wait(for: ECommerceStoreWaitTimes.medium.rawValue)

    let productCellIdentifier = ECommerceStoreIdentifiers.productCell
    let productName = app.tables.children(matching: .cell).matching(identifier: productCellIdentifier).element(boundBy: 4).staticTexts[ECommerceStoreIdentifiers.productName]
    let productStock = app.tables.children(matching: .cell).matching(identifier: productCellIdentifier).element(boundBy: 4).staticTexts[ECommerceStoreIdentifiers.productQuantity]
    XCTAssertTrue(productName.label == "Flip Flops, Blue")
    XCTAssertTrue(productStock.label == "0")
    
    let button = app.tables.children(matching: .cell).matching(identifier: ECommerceStoreIdentifiers.productCell).element(boundBy: 4).buttons[ECommerceStoreIdentifiers.addToCartButton]
    XCTAssertFalse(button.exists)
  }
  
  // UserStory 7:
  // As a Customer I can remove a product from my wishlist.
  func testUserCanRemoveAProductFromWishlist() {
    let app = XCUIApplication()
    app.launch()
    wait(for: ECommerceStoreWaitTimes.medium.rawValue)
    
    let button = app.tables.children(matching: .cell).matching(identifier: ECommerceStoreIdentifiers.productCell).firstMatch.buttons[ECommerceStoreIdentifiers.addToWishlistButton]
    button.tap()
    app.alerts.scrollViews.otherElements.buttons[ECommerceStoreIdentifiers.okButton].tap()
    app.tabBars.buttons[ECommerceStoreIdentifiers.wishListButton].tap()
    
    let productName = app.tables.children(matching: .cell).matching(identifier: ECommerceStoreIdentifiers.wishListTableViewCell).firstMatch.staticTexts[ECommerceStoreIdentifiers.productName]
    XCTAssertTrue(productName.label == "Almond Toe Court Shoes, Patent Black")
    
    let removeFromWishListButton = app.tables.descendants(matching: .button).matching(identifier:ECommerceStoreIdentifiers.removeFromWishlistButton).firstMatch
    removeFromWishListButton.tap()
    app.alerts.scrollViews.otherElements.buttons[ECommerceStoreIdentifiers.okButton].tap()

    let productNameAfterRemoval = app.tables.children(matching: .cell).matching(identifier: ECommerceStoreIdentifiers.wishListTableViewCell).firstMatch.staticTexts[ECommerceStoreIdentifiers.productName]
    XCTAssertFalse(productNameAfterRemoval.exists)
  }

}
