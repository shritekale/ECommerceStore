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

  init(viewCellDelegate: ProductViewCellDelegate) {
      self.viewCellDelegate = viewCellDelegate
  }
  
  func updateProducts(products: [Product]) {
    self.products = products
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
  
}
