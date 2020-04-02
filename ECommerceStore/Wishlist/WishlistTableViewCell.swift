//
//  WishlistTableViewCell.swift
//  ECommerceStore
//
//  Created by Shrikantreddy Tekale on 02/04/2020.
//  Copyright © 2020 Shrikantreddy Tekale. All rights reserved.
//

import UIKit

protocol WishlistTableViewCellDelegate {
  func removeProductFromWishList(_ viewModel: WishListRepresentable)
}

class WishlistTableViewCell: UITableViewCell {
  
  @IBOutlet private weak var nameLabel: UILabel!
  @IBOutlet private weak var categoryLabel: UILabel!

  private var delegate: WishlistTableViewCellDelegate?
  private var viewModel: WishListRepresentable?

  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  func configure(withViewModel viewModel: WishListRepresentable, delegate:WishlistTableViewCellDelegate) {
    self.viewModel = viewModel
    self.delegate = delegate
    nameLabel.text = viewModel.productName
    categoryLabel.text = viewModel.productCategory
  }
  
  @IBAction func removeFromWishListPressed() {
    guard let viewModel = viewModel else {
      return
    }
    
    delegate?.removeProductFromWishList(viewModel)
  }
  
}
