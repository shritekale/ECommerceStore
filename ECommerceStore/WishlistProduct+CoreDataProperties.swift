//
//  WishlistProduct+CoreDataProperties.swift
//  ECommerceStore
//
//  Created by Shrikantreddy Tekale on 01/04/2020.
//  Copyright © 2020 Shrikantreddy Tekale. All rights reserved.
//
//

import Foundation
import CoreData

extension WishlistProduct {
  
  @nonobjc public class func fetchRequest() -> NSFetchRequest<WishlistProduct> {
    return NSFetchRequest<WishlistProduct>(entityName: "WishlistProduct")
  }
  
  @NSManaged public var id: Int16
  @NSManaged public var name: String?
  @NSManaged public var category: String?
  @NSManaged public var price: String?
  @NSManaged public var oldPrice: String?
  @NSManaged public var stock: Int16
  
}
