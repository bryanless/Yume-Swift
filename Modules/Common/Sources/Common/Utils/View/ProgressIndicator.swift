//
//  ProgressIndicator.swift
//  Yume
//
//  Created by Bryan on 30/12/22.
//

import Core
import SwiftUI

public struct ProgressIndicator: View {
  private var _label = "Loading"

  public init(
    label: String = "Loading"
  ) {
    _label = label
  }

  public var body: some View {
    GeometryReader { geo in
      VStack(spacing: Space.medium) {
        ProgressView()
          .tint(YumeColor.onSurfaceVariant)
        Text(_label)
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
