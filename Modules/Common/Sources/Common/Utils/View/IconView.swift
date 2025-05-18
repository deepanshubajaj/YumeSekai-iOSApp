//
//  IconView.swift
//  Yume
//
//  Created by Deepanshu Bajaj on 05/05/25.
//

import SwiftUI

public struct IconView: View {
  let icon: UIImage
  let color: Color
  let size: CGFloat

  public init(
    icon: UIImage,
    color: Color = .black,
    size: CGFloat = IconSize.medium
  ) {
    self.icon = icon
    self.color = color
    self.size = size
  }

  public var body: some View {
    Image(uiImage: icon)
      .resizable()
      .foregroundColor(color)
      .frame(width: size, height: size)
  }
}

struct IconView_Previews: PreviewProvider {
  static var previews: some View {
    IconView(icon: Icons.trendingUp, color: .green, size: IconSize.medium)
  }
}
