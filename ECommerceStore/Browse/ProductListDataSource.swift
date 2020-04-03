//
//  ProductListDataSource.swift
//  ECommerceStore
//
//  Created by Shrikantreddy Tekale on 31/03/2020.
//  Copyright © 2020 Shrikantreddy Tekale. All rights reserved.
//

import UIKit
import ECommerceStoreAPI

class ProductListDataSource: NSObject, UITableViewDataSource {

  private var products : [Product] = [Product]()
  private let viewCellDelegate: ProductViewCellDelegate
  private let tableView: UITableView
  var apiRequests = ECommerceStoreAPIRequests.self

  init(tableView: UITableView, viewCellDelegate: ProductViewCellDelegate) {
    self.viewCellDelegate = viewCellDelegate
    self.tableView = tableView
  }
  
  func updateProducts() {
    fetchProducts()
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return products.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ProductViewCell", for: indexPath) as! ProductViewCell
    let viewModel = ProductViewModel(product: products[indexPath.row])
    cell.configure(withViewModel: viewModel, delegate: viewCellDelegate)
    return cell
  }
  
  private func fetchProducts() {
    apiRequests.fetchProducts { [weak self] (result: ProductResult<ProductResponse>) in
        switch result {
        case .success(let response):
          self?.products = response.products
          self?.tableView.reloadData()
        case .failure(_):
          print("error")
        }
    }
  }
  
}
