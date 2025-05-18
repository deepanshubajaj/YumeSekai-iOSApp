//
//  AnimeInformationItem.swift
//  YumeSekai
//
//  Created by Deepanshu Bajaj on 05/05/25.
//

import Common
import Core
import SwiftUI

public struct AnimeInformationItem: View {
  @State var label: String
  @State var value: String

  public var body: some View {
    VStack(alignment: .leading, spacing: Space.none) {
      Text(label)
        .typography(.body(color: YumeColor.onSurfaceVariant))
      Text(value)
        .typography(.body(color: YumeColor.onBackground))
    }
  }
}

struct AnimeInformationItem_Previews: PreviewProvider {
  static var previews: some View {
    AnimeInformationItem(label: "Episodes", value: "13")
  }
}
