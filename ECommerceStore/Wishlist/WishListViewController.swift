//
//  SecondViewController.swift
//  ECommerceStore
//
//  Created by Shrikantreddy Tekale on 29/03/2020.
//  Copyright © 2020 Shrikantreddy Tekale. All rights reserved.
//

import UIKit

class WishListViewController: UIViewController, WishlistTableViewCellDelegate {
  
  @IBOutlet weak var wishListTableView: UITableView!

  private var wishListDataSource: WishListDataSource?

  override func viewDidLoad() {
    super.viewDidLoad()
    
    wishListDataSource = WishListDataSource(viewCellDelegate: self)
    wishListTableView.dataSource = wishListDataSource
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    wishListDataSource?.updateProducts()
    wishListTableView.reloadData()
  }
    
  func removeProductFromWishList(_ viewModel: WishListRepresentable) {
    let wishListController = WishListDataController()
    do {
      try wishListController.removeProductFromWishlist(viewModel: viewModel)
    } catch  {
      showSimpleAlert(withMessage: "Something went wrong while removing product from wishlist")
      return
    }
    
    showSimpleAlert(withMessage: "\(viewModel.productName) removed from wishlist")
    wishListDataSource?.updateProducts()
    wishListTableView.reloadData()
  }

}

