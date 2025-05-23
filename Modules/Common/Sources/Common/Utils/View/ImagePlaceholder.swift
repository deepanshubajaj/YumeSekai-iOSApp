//
//  ImagePlaceholder.swift
//  
//
//  Created by Deepanshu Bajaj on 05/05/25.
//

import Core
import SwiftUI

public struct ImagePlaceholder: View {

  public init() {}

  public var body: some View {
    VStack {
      IconView(
        icon: Icons.imageOutlined,
        color: YumeColor.onSurfaceVariant)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(YumeColor.surfaceVariant)
  }
}

struct ImagePlaceholder_Previews: PreviewProvider {
  static var previews: some View {
    ImagePlaceholder()
  }
}
