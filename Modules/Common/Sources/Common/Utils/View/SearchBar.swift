//
//  SearchBar.swift
//  Yume
//
//  Created by Bryan on 30/12/22.
//

import Core
import SwiftUI

struct SearchBar: View {
  let placeholder: String
  @Binding var searchText: String

  var body: some View {
    HStack {
      IconView(
        icon: Icons.search,
        color: searchText.isEmpty ? YumeColor.onSurfaceVariant : YumeColor.onSurface,
        size: IconSize.small
      )

      ZStack(alignment: .leading) {
        if searchText.isEmpty {
          Text(placeholder)
            .typography(
              .body(
                color: YumeColor.onSurfaceVariant
              )
            )
        }
        TextField("", text: $searchText)
          .typography(
            .body(
              color: searchText.isEmpty ? YumeColor.onSurfaceVariant : YumeColor.onSurface
            )
          )
          .tint(YumeColor.primary)
          .autocorrectionDisabled(true)
      }
    }
    .padding(
      EdgeInsets(
        top: Space.small,
        leading: Space.medium,
        bottom: Space.small,
        trailing: Space.medium)
    )
    .background(YumeColor.surfaceVariant)
    .cornerRadius(Shape.rounded)
  }
}

struct SearchBar_Previews: PreviewProvider {
  static var previews: some View {
    SearchBar(placeholder: "Search anime", searchText: .constant(""))
  }
}
