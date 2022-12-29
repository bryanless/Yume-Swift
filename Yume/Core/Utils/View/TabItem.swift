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

  var body: some View {
    GeometryReader { geo in
      VStack(alignment: .center, spacing: Space.tiny) {
        IconView(icon: icon)
        Text(label)
          .typography(.caption())
      }.frame(width: geo.size.width, height: geo.size.height)
    }
  }
}

struct TabItem_Previews: PreviewProvider {
  static var previews: some View {
    TabItem(icon: Icons.houseOutlined, label: "Home")
  }
}
