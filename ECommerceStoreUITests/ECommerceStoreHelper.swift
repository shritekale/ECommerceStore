//
//  ECommerceStoreHelper.swift
//  ECommerceStoreUITests
//
//  Created by Shrikantreddy Tekale on 04/04/2020.
//  Copyright © 2020 Shrikantreddy Tekale. All rights reserved.
//

import Foundation
import XCTest

class ECommerceStoreHelper {

  let app: XCUIApplication
  init(app: XCUIApplication) {
    self.app = app
  }
  
  func removeAllItemsFromWishList() {
    app.tabBars.buttons[ECommerceStoreIdentifiers.wishListButton].tap()
    let removeFromWishlistButtonQuery = app.tables.descendants(matching: .button).matching(identifier:ECommerceStoreIdentifiers.removeFromWishlistButton)
    let allButtons = removeFromWishlistButtonQuery.allElementsBoundByIndex
    var count = removeFromWishlistButtonQuery.count
    
    while count > 0 {
      allButtons.first?.tap()
      app.alerts.scrollViews.otherElements.buttons[ECommerceStoreIdentifiers.okButton].tap()
      count -= 1
    }
  }
  
  func removeAllItemsFromCart() {
    app.tabBars.buttons[ECommerceStoreIdentifiers.cartButton].tap()
    let removeFromCartButtonQuery = app.tables.descendants(matching: .button).matching(identifier:ECommerceStoreIdentifiers.removeFromCartButton)
    let allButtons = removeFromCartButtonQuery.allElementsBoundByIndex
    var count = removeFromCartButtonQuery.count
    
    while count > 0 {
      allButtons.first?.tap()
      app.alerts.scrollViews.otherElements.buttons[ECommerceStoreIdentifiers.okButton].tap()
      count -= 1
    }
  }
}
