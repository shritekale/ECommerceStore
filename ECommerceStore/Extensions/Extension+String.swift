//
//  Extension+String.swift
//  ECommerceStore
//
//  Created by Shrikantreddy Tekale on 31/03/2020.
//  Copyright © 2020 Shrikantreddy Tekale. All rights reserved.
//

import Foundation

extension String {
    func strikeThrough() -> NSAttributedString {
        let attributeString =  NSMutableAttributedString(string: self)
        attributeString.addAttribute( NSAttributedString.Key.strikethroughStyle, value: 1, range:NSMakeRange(0,attributeString.length))
        return attributeString
    }
}
