//
//  NavigationExtension.swift
//  Yume
//
//  Created by Bryan on 30/12/22.
//

import UIKit

extension UINavigationController {
  open override func viewDidLoad() {
    super.viewDidLoad()
    interactivePopGestureRecognizer?.delegate = nil
  }
}
