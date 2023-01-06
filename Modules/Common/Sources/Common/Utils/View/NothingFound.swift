//
//  NothingFound.swift
//  Yume
//
//  Created by Bryan on 30/12/22.
//

import Core
import SwiftUI

struct NothingFound: View {
  var label: String

  var body: some View {
    GeometryReader { geo in
      VStack {
        Text(label)
          .typography(.body(color: YumeColor.onSurfaceVariant))
      }
      .frame(width: geo.size.width, height: geo.size.height)
    }
  }
}

struct NothingFound_Previews: PreviewProvider {
  static var previews: some View {
    NothingFound(label: "No favorite anime")
  }
}
