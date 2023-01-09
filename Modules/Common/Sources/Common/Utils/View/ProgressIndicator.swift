//
//  ProgressIndicator.swift
//  Yume
//
//  Created by Bryan on 30/12/22.
//

import Core
import SwiftUI

public struct ProgressIndicator: View {
  private let _label: String

  public init(
    label: String = "loading_label"
  ) {
    _label = label
  }

  public var body: some View {
    GeometryReader { geo in
      VStack(spacing: Space.medium) {
        ProgressView()
          .tint(YumeColor.onSurfaceVariant)
        Text(_label.localized(bundle: .common))
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
