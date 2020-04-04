//
//  XCTestCase+Wait.swift
//  ECommerceStoreUITests
//
//  Created by Shrikantreddy Tekale on 03/04/2020.
//  Copyright © 2020 Shrikantreddy Tekale. All rights reserved.
//

import XCTest

extension XCTestCase {
  func wait(for duration: TimeInterval) {
    let waitExpectation = expectation(description: "Waiting")

    let when = DispatchTime.now() + duration
    DispatchQueue.main.asyncAfter(deadline: when) {
      waitExpectation.fulfill()
    }

    // We use a buffer here to avoid flakiness with Timer on CI
    waitForExpectations(timeout: duration + 0.5)
  }
}
