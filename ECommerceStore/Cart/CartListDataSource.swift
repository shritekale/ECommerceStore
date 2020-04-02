//
//  ProductListDataSource.swift
//  ECommerceStore
//
//  Created by Shrikantreddy Tekale on 31/03/2020.
//  Copyright © 2020 Shrikantreddy Tekale. All rights reserved.
//

import UIKit
import ECommerceStoreAPI

class CartListDataSource: NSObject, UITableViewDataSource {

  private var cartItems : [CartItem] = [CartItem]()
  private var products : [Product] = [Product]()

  private let viewCellDelegate: CartItemTableViewCellDelegate
  private let tableView: UITableView

  init(tableView: UITableView, viewCellDelegate: CartItemTableViewCellDelegate) {
    self.viewCellDelegate = viewCellDelegate
    self.tableView = tableView
  }
  
  func updateCartItems() {
    fetchCartItems()
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return cartItems.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "CartItemTableViewCell", for: indexPath) as! CartItemTableViewCell
    if let viewModel = getViewModelFor(productId: cartItems[indexPath.row].id) {
      cell.configure(withViewModel: viewModel, delegate: viewCellDelegate)
    }
    return cell
  }
    
  private func fetchCartItems() {
    ECommerceStoreAPIRequests.fetchCart { [weak self] (result: GetCartResult<CartResponse>) in
        switch result {
        case .success(let response):
          self?.cartItems = response.cartItems
          if response.cartItems.count > 0 {
            self?.fetchProducts()
          }
        case .failure(_):
          print("error")
        }
    }
  }
  
  private func fetchProducts() {
    ECommerceStoreAPIRequests.fetchProducts { [weak self] (result: ProductResult<ProductResponse>) in
        switch result {
        case .success(let response):
          self?.products = response.products
          self?.tableView.reloadData()
        case .failure(_):
          print("error")
        }
    }
  }
  
  private func getViewModelFor(productId: Int) -> ProductViewModel? {
    if let product = products.first(where: {$0.id == productId}) {
      return ProductViewModel(product: product)
    } else {
      return nil
    }
  }
  
}
