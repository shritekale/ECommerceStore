//
//  WishListDataSource.swift
//  ECommerceStore
//
//  Created by Shrikantreddy Tekale on 02/04/2020.
//  Copyright © 2020 Shrikantreddy Tekale. All rights reserved.
//

import UIKit

class WishListDataSource: NSObject, UITableViewDataSource {

  private var products : [WishlistProduct] = [WishlistProduct]()
  private let wishListDataController = WishListDataController()
  private let viewCellDelegate: WishlistTableViewCellDelegate

  init(viewCellDelegate: WishlistTableViewCellDelegate) {
    self.viewCellDelegate = viewCellDelegate
  }
  
  func updateProducts() {
    do {
      if let products =  try wishListDataController.getWishlist() {
        self.products = products
      }
    } catch  {
      print("Show error")
    }
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return products.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "WishlistTableViewCell", for: indexPath) as! WishlistTableViewCell
    let viewModel = WishListViewModel(product: products[indexPath.row])
    cell.configure(withViewModel: viewModel, delegate: viewCellDelegate)
    return cell
  }
  
}
