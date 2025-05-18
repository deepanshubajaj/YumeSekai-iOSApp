//
//  SwiftUIView.swift
//  
//
//  Created by Deepanshu Bajaj on 05/05/25.
//

import Core
import SwiftUI

struct FilledButton: ButtonStyle {
  @State private var pressed = false

  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .padding(
        EdgeInsets(
          top: Space.small,
          leading: Space.large,
          bottom: Space.small,
          trailing: Space.large)
      )
      .background(YumeColor.primary)
      .compositingGroup()
      .opacity(configuration.isPressed ? 0.5 : 1.0)
      .clipShape(Capsule())
  }
}
