//
//  RepresentableProtocols.swift
//  ECommerceStore
//
//  Created by Shrikantreddy Tekale on 02/04/2020.
//  Copyright © 2020 Shrikantreddy Tekale. All rights reserved.
//

import Foundation

protocol WishListRepresentable {
  var productId: Int { get }
  var productName: String { get }
  var productCategory: String { get }
}

protocol ProductRepresentable: WishListRepresentable {
  var productPrice: String { get }
  var productOldPrice: String { get }
  var productStock: Int { get }
}

protocol CartRepresentable: WishListRepresentable {
  var productCartId: Int { get }
}
