//
//  ProgressIndicator.swift
//  Yume
//
//  Created by Bryan on 30/12/22.
//

import Core
import SwiftUI

struct ProgressIndicator: View {
  var label = "Loading"

    var body: some View {
      GeometryReader { geo in
        VStack(spacing: Space.medium) {
          ProgressView()
            .tint(YumeColor.onSurfaceVariant)
          Text(label)
            .typography(.body(color: YumeColor.onSurfaceVariant))
        }
        .frame(width: geo.size.width, height: geo.size.height)
      }
    }
}

struct ProgressIndicator_Previews: PreviewProvider {
    static var previews: some View {
        ProgressIndicator(label: "Searching anime")
    }
}
