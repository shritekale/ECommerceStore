//
//  CartViewController.swift
//  ECommerceStore
//
//  Created by Shrikantreddy Tekale on 02/04/2020.
//  Copyright © 2020 Shrikantreddy Tekale. All rights reserved.
//

import UIKit
import ECommerceStoreAPI

class CartViewController: UIViewController, CartItemTableViewCellDelegate {
  
  @IBOutlet weak var cartTableView: UITableView!
  
  private var cartListDataSource: CartListDataSource?

  override func viewDidLoad() {
    super.viewDidLoad()
    
    cartListDataSource = CartListDataSource(tableView: cartTableView, viewCellDelegate: self)
    cartTableView.dataSource = cartListDataSource
    cartListDataSource?.updateCartItems()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    cartListDataSource?.updateCartItems()
  }

  private func fetchCartItems() {
    ECommerceStoreAPIRequests.fetchCart { [weak self] (result: GetCartResult<CartResponse>) in
        switch result {
        case .success(let response):
          print(response.cartItems.count)
        case .failure(_):
          self?.showSimpleAlert(withMessage: "Something went wrong while fetching cart")
        }
    }
  }

  func removeProductFromCart(_ viewModel: CartRepresentable) {
    ECommerceStoreAPIRequests.deleteProductFromCart(cartId: viewModel.productCartId) { [weak self] (result: DeleteFromCartResult<DeleteFromCartResponse>) in
        switch result {
        case .success(_):
          self?.showSimpleAlert(withMessage: "Product deleted from cart")
          self?.cartListDataSource?.updateCartItems()
        case .failure(_):
          self?.showSimpleAlert(withMessage: "Something went wrong while deleting product from cart")
        }
    }
  }

  
}
