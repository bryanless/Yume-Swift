//
//  TabItem.swift
//  Yume
//
//  Created by Bryan on 29/12/22.
//

import SwiftUI

struct TabItem: View {
  let icon: UIImage
  let label: String
  let isActive: Bool
  let onTap: () -> Void

  var body: some View {
    let color = isActive ? YumeColor.onSurface : YumeColor.onSurfaceVariant
    GeometryReader { geo in
      VStack(alignment: .center, spacing: Space.tiny) {
        IconView(icon: icon, color: color)
        Text(label)
          .typography(.caption(color: color))
      }
      .frame(width: geo.size.width, height: geo.size.height)
      .onTapGesture {
        withAnimation(.easeIn(duration: 0.1)) {
          onTap()
        }
      }
    }
  }
}

struct TabItem_Previews: PreviewProvider {
  static var previews: some View {
    TabItem(icon: Icons.houseOutlined, label: "Home", isActive: true) {

    }
  }
}
