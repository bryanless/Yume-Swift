//
//  AnimeInformationItem.swift
//  Yume
//
//  Created by Bryan on 30/12/22.
//

import Common
import Core
import SwiftUI

struct AnimeInformationItem: View {
  @State var label: String
  @State var value: String

  var body: some View {
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
