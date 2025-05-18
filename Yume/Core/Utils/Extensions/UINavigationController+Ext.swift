//
//  UINavigationController+Ext.swift
//  YumeSekai
//
//  Created by Deepanshu Bajaj on 02/05/25.
//

import UIKit

extension UINavigationController {
  open override func viewDidLoad() {
    super.viewDidLoad()
    interactivePopGestureRecognizer?.delegate = nil
  }
}
