//
//  WishListController.swift
//  ECommerceStore
//
//  Created by Shrikantreddy Tekale on 01/04/2020.
//  Copyright © 2020 Shrikantreddy Tekale. All rights reserved.
//

import UIKit
import CoreData
import ECommerceStoreAPI

class WishListDataController {
  
  var persistentContainer: NSPersistentContainer
  
  init?() {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
      return nil
    }
    
    persistentContainer = appDelegate.persistentContainer
  }
  
  func addProductToWishlist(viewModel: ProductRepresentable) throws {
    
    let managedContext = persistentContainer.viewContext
    let wishlistProduct = WishlistProduct(context: managedContext)
    wishlistProduct.id = Int16(viewModel.productId)
    wishlistProduct.name = viewModel.productName
    wishlistProduct.category = viewModel.productCategory
    wishlistProduct.price = viewModel.productPrice
    wishlistProduct.stock = Int16(viewModel.productStock)
    wishlistProduct.oldPrice = viewModel.productOldPrice
    
    managedContext.insert(wishlistProduct)
    try managedContext.save()
  }
  
  func removeProductFromWishlist(viewModel: ProductRepresentable) throws {
    let managedContext = persistentContainer.viewContext
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "WishlistProduct")
    request.predicate = NSPredicate(format: "id == %d", Int16(viewModel.productId))
    let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
    try managedContext.execute(deleteRequest)
    try managedContext.save()
  }
  
  func getWishlistProduct(withId id: Int) throws -> [WishlistProduct]? {
      let request = NSFetchRequest<WishlistProduct>(entityName: "WishlistProduct")
      request.predicate = NSPredicate(format: "id == %d", Int16(id))
      let products = try persistentContainer.viewContext.fetch(request)
      return products
  }

  func getWishlist() throws -> [WishlistProduct]? {
    let fetchRequest = WishlistProduct.fetchRequest() as NSFetchRequest<WishlistProduct>
    let products = try persistentContainer.viewContext.fetch(fetchRequest)
    return products
  }
  
}
