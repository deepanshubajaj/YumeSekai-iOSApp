//
//  YumeDivider.swift
//  Yume
//
//  Created by Deepanshu Bajaj on 05/05/25.
//

import Core
import SwiftUI

public struct YumeDivider: View {

  public init() {}

  public var body: some View {
    Divider()
      .overlay(YumeColor.outlineVariant)
  }
}

struct YumeDivider_Previews: PreviewProvider {
  static var previews: some View {
    YumeDivider()
  }
}
