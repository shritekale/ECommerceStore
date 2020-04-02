//
//  FirstViewController.swift
//  ECommerceStore
//
//  Created by Shrikantreddy Tekale on 29/03/2020.
//  Copyright © 2020 Shrikantreddy Tekale. All rights reserved.
//

import UIKit
import ECommerceStoreAPI

class FirstViewController: UIViewController, ProductViewCellProtocol {
  
  @IBOutlet weak var productTableView: UITableView!
  
  var productListDataSource: ProductListDataSource?

  override func viewDidLoad() {
    super.viewDidLoad()
    
    productListDataSource = ProductListDataSource(viewCellDelegate: self)
    productTableView.dataSource = productListDataSource
    fetchProducts()
  }
  
  private func fetchProducts() {
    ECommerceStoreAPIRequests.fetchProducts { [weak self] (result: ProductResult<ProductResponse>) in
        switch result {
        case .success(let response):
          self?.productListDataSource?.products = response.products
          DispatchQueue.main.async {
            self?.productTableView.reloadData()
          }
        case .failure(let error):
          print(error.localizedDescription)
          self?.showAlert(message: "Something went wrong while fetching products")
        }
    }
  }
  
  func addProductToCart(_ viewModel: ProductRepresentable) {
    ECommerceStoreAPIRequests.addProductToCart(productId: viewModel.productId) { [weak self] (result: AddToCartResult<AddToCartResponse>) in
        switch result {
        case .success(let response):
          self?.showAlert(message: response.message)
          self?.fetchProducts()
        case .failure(let error):
          print(error.localizedDescription)
          self?.showAlert(message: error.localizedDescription)
        }
    }
  }
  
  func addProductToWishList(_ viewModel: ProductRepresentable) {
    guard let wishListController = WishListDataController() else {
      return
    }
    
    do {
      try wishListController.addProductToWishlist(viewModel: viewModel)
    } catch  {
      showAlert(message: "Something went wrong while adding product to wishlist")
      return
    }
    
    showAlert(message: "\(viewModel.productName) added to wishlist")
    productTableView.reloadData()
  }
  
  func removeProductFromWishList(_ viewModel: ProductRepresentable) {
    guard let wishListController = WishListDataController() else {
      return
    }
    
    do {
      try wishListController.removeProductFromWishlist(viewModel: viewModel)
    } catch  {
      showAlert(message: "Something went wrong while removing product from wishlist")
      return
    }
    
    showAlert(message: "\(viewModel.productName) removed from wishlist")
    productTableView.reloadData()
  }

  
  private func showAlert(message: String) {
    let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
    self.present(alert, animated: true)
  }
  
}

