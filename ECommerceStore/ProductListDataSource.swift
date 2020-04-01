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

  var products : [Product] = [Product]()
  var viewCellDelegate: ProductViewCellProtocol

  init(viewCellDelegate: ProductViewCellProtocol) {
      self.viewCellDelegate = viewCellDelegate
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return products.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ProductViewCell", for: indexPath) as! ProductViewCell
    cell.delegate = viewCellDelegate
    cell.updateCellWithProduct(products[indexPath.row])
    return cell
  }
  
}
