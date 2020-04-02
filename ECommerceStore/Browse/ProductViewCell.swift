//
//  ProductViewCell.swift
//  ECommerceStore
//
//  Created by Shrikantreddy Tekale on 31/03/2020.
//  Copyright © 2020 Shrikantreddy Tekale. All rights reserved.
//

import UIKit
import ECommerceStoreAPI

protocol ProductViewCellDelegate {
  func addProductToCart(_ viewModel: ProductRepresentable)
  func addProductToWishList(_ viewModel: ProductRepresentable)
  func removeProductFromWishList(_ viewModel: ProductRepresentable)
}

class ProductViewCell: UITableViewCell {
  
  @IBOutlet private weak var nameLabel: UILabel!
  @IBOutlet private weak var categoryLabel: UILabel!
  @IBOutlet private weak var priceLabel: UILabel!
  @IBOutlet private weak var oldPriceLabel: UILabel!
  @IBOutlet private weak var quantityLabel: UILabel!
  
  @IBOutlet private weak var addToCartButton: UIButton!
  @IBOutlet private weak var addToWishListButton: UIButton!
  @IBOutlet private weak var removeFromWishListButton: UIButton!
  
  private var delegate: ProductViewCellDelegate?
  private var viewModel: ProductRepresentable?
    
  func configure(withViewModel viewModel: ProductRepresentable, delegate:ProductViewCellDelegate) {
    self.viewModel = viewModel
    self.delegate = delegate
    nameLabel.text = viewModel.productName
    categoryLabel.text = viewModel.productCategory
    priceLabel.text = viewModel.productPrice
    quantityLabel.text = String(viewModel.productStock)
    oldPriceLabel.attributedText = viewModel.productOldPrice.strikeThrough()
    addToCartButton.isHidden = viewModel.productStock == 0 ? true : false
    
    updateWishListStatus(productId: viewModel.productId)
  }
  
  private func updateWishListStatus(productId: Int) {
    let wishListController = WishListDataController()
    do {
      let wishListProduct = try wishListController.getWishlistProduct(withId: productId)
      if wishListProduct?.count == 0 {
        addToWishListButton.isHidden = false
        removeFromWishListButton.isHidden = true
      } else {
        addToWishListButton.isHidden = true
        removeFromWishListButton.isHidden = false
      }
    } catch  {
      addToWishListButton.isHidden = true
      removeFromWishListButton.isHidden = true
    }
  }
  
  @IBAction func addToCartPressed() {
    guard let viewModel = viewModel else {
      return
    }
    
    delegate?.addProductToCart(viewModel)
  }
  
  @IBAction func addToWishlistPressed() {
    guard let viewModel = viewModel else {
      return
    }
    
    delegate?.addProductToWishList(viewModel)
  }
  
  @IBAction func removeProductFromWishListPressed() {
    guard let viewModel = viewModel else {
      return
    }
    
    delegate?.removeProductFromWishList(viewModel)
  }

}

