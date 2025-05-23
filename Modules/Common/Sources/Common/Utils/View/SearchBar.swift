//
//  SearchBar.swift
//  Yume
//
//  Created by Deepanshu Bajaj on 05/05/25.
//

import Core
import SwiftUI

public struct SearchBar: View {
  let placeholder: String
  @Binding var searchText: String

  public init(
    placeholder: String,
    searchText: Binding<String>
  ) {
    self.placeholder = placeholder
    self._searchText = searchText
  }

  public var body: some View {
    HStack {
      IconView(
        icon: Icons.search,
        color: searchText.isEmpty ? YumeColor.onSurfaceVariant : YumeColor.onSurface,
        size: IconSize.small
      )

      ZStack(alignment: .leading) {
        if searchText.isEmpty {
          Text(placeholder)
            .typography(
              .body(
                color: YumeColor.onSurfaceVariant
              )
            )
        }
        TextField("", text: $searchText)
          .typography(
            .body(
              color: searchText.isEmpty ? YumeColor.onSurfaceVariant : YumeColor.onSurface
            )
          )
          .tint(YumeColor.primary)
          .autocorrectionDisabled(true)
      }
    }
    .padding(
      EdgeInsets(
        top: Space.small,
        leading: Space.medium,
        bottom: Space.small,
        trailing: Space.medium)
    )
    .background(YumeColor.surfaceVariant)
    .cornerRadius(Shape.small)
  }
}

struct SearchBar_Previews: PreviewProvider {
  static var previews: some View {
    SearchBar(placeholder: "Search anime", searchText: .constant(""))
  }
}
