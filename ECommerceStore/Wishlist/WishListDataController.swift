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
  
  let persistentContainer: NSPersistentContainer!
  
  init(container: NSPersistentContainer) {
      self.persistentContainer = container
      self.persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
  }
  
  convenience init() {
      let appDelegate = UIApplication.shared.delegate as! AppDelegate
      self.init(container: appDelegate.persistentContainer)
  }
  
  func addProductToWishlist(viewModel: WishListRepresentable) throws {
    let managedContext = persistentContainer.viewContext
    let wishlistProduct = WishlistProduct(context: managedContext)
    wishlistProduct.id = Int16(viewModel.productId)
    wishlistProduct.name = viewModel.productName
    wishlistProduct.category = viewModel.productCategory
    
    managedContext.insert(wishlistProduct)
    try managedContext.save()
  }
  
  func removeProductFromWishlist(viewModel: WishListRepresentable) throws {
    let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest<NSFetchRequestResult>(entityName: "WishlistProduct")
    fetchRequest.predicate = NSPredicate(format: "id == %d", Int16(viewModel.productId))
    try removeProductsWithFetchRequest(fetchRequest)
  }
  
  func removeAllProductsFromWishlist() throws {
    let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest<NSFetchRequestResult>(entityName: "WishlistProduct")
    try removeProductsWithFetchRequest(fetchRequest)
  }
  
  private func removeProductsWithFetchRequest(_ request: NSFetchRequest<NSFetchRequestResult>) throws {
    let managedContext = persistentContainer.viewContext
    let products = try managedContext.fetch(request)
    for case let product as NSManagedObject in products {
      managedContext.delete(product)
    }
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
