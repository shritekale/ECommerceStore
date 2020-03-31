//
//  TestProducts.swift
//  ECommerceStoreTests
//
//  Created by Shrikantreddy Tekale on 31/03/2020.
//  Copyright © 2020 Shrikantreddy Tekale. All rights reserved.
//

import Foundation
import ECommerceStoreAPI

class TestProducts {
  static func getProducts() -> [Product] {
    let path = Bundle(for: TestProducts.self).path(forResource: "TestProducts", ofType: "json")
    let data = try! Data(contentsOf: URL(fileURLWithPath: path!), options: .mappedIfSafe)
    let products: [Product] = try! JSONDecoder().decode([Product].self, from: data)
    return products
  }
}
