//
//  FirstViewController.swift
//  ECommerceStore
//
//  Created by Shrikantreddy Tekale on 29/03/2020.
//  Copyright © 2020 Shrikantreddy Tekale. All rights reserved.
//

import UIKit
import ECommerceStoreAPI

class FirstViewController: UIViewController {
  
  @IBOutlet weak var productTableView: UITableView!
  
  var productListDataSource = ProductListDataSource()

  override func viewDidLoad() {
    super.viewDidLoad()
    
    productTableView.dataSource = productListDataSource
    
    ECommerceStoreAPIRequests.fetchProducts { [weak self] (result: ProductResult<ProductResponse>) in
        switch result {
        case .success(let response):
          self?.updateProducts(response.products)
        case .failure(let error):
            print("\(error)")
        }
    }
  }
  
  private func updateProducts(_ products: [Product]) {
    productListDataSource.products = products
    DispatchQueue.main.async {
      self.productTableView.reloadData()
    }
  }
  
}

