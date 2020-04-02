//
//  CartItemTableViewCell.swift
//  ECommerceStore
//
//  Created by Shrikantreddy Tekale on 02/04/2020.
//  Copyright © 2020 Shrikantreddy Tekale. All rights reserved.
//

import UIKit

protocol CartItemTableViewCellDelegate {
  func removeProductFromCart(_ viewModel: CartRepresentable)
}

class CartItemTableViewCell: UITableViewCell {
  
  @IBOutlet private weak var nameLabel: UILabel!
  @IBOutlet private weak var categoryLabel: UILabel!

  private var delegate: CartItemTableViewCellDelegate?
  private var viewModel: CartRepresentable?

  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  func configure(withViewModel viewModel: CartRepresentable, delegate:CartItemTableViewCellDelegate) {
    self.viewModel = viewModel
    self.delegate = delegate
    nameLabel.text = viewModel.productName
    categoryLabel.text = viewModel.productCategory
  }

  @IBAction func removeProductCartPressed() {
    guard let viewModel = viewModel else {
      return
    }
    
    delegate?.removeProductFromCart(viewModel)
  }
  
}
