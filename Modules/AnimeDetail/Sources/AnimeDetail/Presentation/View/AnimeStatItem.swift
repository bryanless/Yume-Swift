//
//  AnimeStatItem.swift
//  Yume
//
//  Created by Bryan on 30/12/22.
//

import Common
import Core
import SwiftUI

public struct AnimeStatItem: View {
  let icon: UIImage
  let iconColor: Color
  @State var label: String
  @State var value: String

  public var body: some View {
    GeometryReader { geo in
      VStack(spacing: Space.tiny) {
        IconView(
          icon: icon,
          color: iconColor
        )
        Text(value)
          .typography(.subheadline(color: YumeColor.onBackground))
        Text(label)
          .typography(.caption(color: YumeColor.onSurfaceVariant))
      }
      .frame(width: geo.size.width, height: geo.size.height)
    }
  }
}

struct AnimeStatItem_Previews: PreviewProvider {
  static var previews: some View {
    AnimeStatItem(icon: Icons.starOutlined, iconColor: .yellow, label: "Score", value: "9.8")
  }
}
