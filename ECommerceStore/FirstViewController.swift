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

  override func viewDidLoad() {
    super.viewDidLoad()
    ECommerceStoreAPIRequests.fetchProducts { (result: ProductResult<ProductResponse>) in
        switch result {
        case .success(let response):
            response.products.forEach { product in
                print("\(product.name)")
            }
        case .failure(let error):
            print("\(error)")
        }
    }
  }
}

