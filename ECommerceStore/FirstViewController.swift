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
  
  func addProductToCart(_ product: Product) {
    ECommerceStoreAPIRequests.addProductToCart(product: product) { [weak self] (result: AddToCartResult<AddToCartResponse>) in
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
  
  func addProductToWishList(_ product: Product) {}
  
  private func showAlert(message: String) {
    let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
    self.present(alert, animated: true)
  }
  
}

