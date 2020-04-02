//
//  FirstViewController.swift
//  ECommerceStore
//
//  Created by Shrikantreddy Tekale on 29/03/2020.
//  Copyright © 2020 Shrikantreddy Tekale. All rights reserved.
//

import UIKit
import ECommerceStoreAPI

class ProductsViewController: UIViewController, ProductViewCellDelegate {
  
  @IBOutlet weak var productTableView: UITableView!
  
  private var productListDataSource: ProductListDataSource?

  override func viewDidLoad() {
    super.viewDidLoad()
    
    productListDataSource = ProductListDataSource(tableView: productTableView, viewCellDelegate: self)
    productTableView.dataSource = productListDataSource
    productListDataSource?.updateProducts()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    productListDataSource?.updateProducts()
  }
  
  // MARK:- Delegate methods
  func addProductToCart(_ viewModel: ProductRepresentable) {
    ECommerceStoreAPIRequests.addProductToCart(productId: viewModel.productId) { [weak self] (result: AddToCartResult<AddToCartResponse>) in
        switch result {
        case .success(let response):
          self?.showSimpleAlert(withMessage: response.message)
          self?.productListDataSource?.updateProducts()
        case .failure(let error):
          print(error.localizedDescription)
          self?.showSimpleAlert(withMessage: error.localizedDescription)
        }
    }
  }
  
  func addProductToWishList(_ viewModel: ProductRepresentable) {
    let wishListController = WishListDataController()
    do {
      try wishListController.addProductToWishlist(viewModel: viewModel)
    } catch  {
      showSimpleAlert(withMessage: "Something went wrong while adding product to wishlist")
      return
    }
    
    showSimpleAlert(withMessage: "\(viewModel.productName) added to wishlist")
    productTableView.reloadData()
  }
  
  func removeProductFromWishList(_ viewModel: ProductRepresentable) {
    let wishListController = WishListDataController()
    do {
      try wishListController.removeProductFromWishlist(viewModel: viewModel)
    } catch  {
      showSimpleAlert(withMessage: "Something went wrong while removing product from wishlist")
      return
    }
    
    showSimpleAlert(withMessage: "\(viewModel.productName) removed from wishlist")
    productTableView.reloadData()
  }

}
