//
//  AppBar.swift
//  Yume
//
//  Created by Bryan on 30/12/22.
//

import SwiftUI

struct AppBar<Content: View>: View {
  var scrollOffset: CGFloat
  let label: String
  let alwaysShowLabel: Bool
  let leading: () -> Content?
  let trailing: () -> Content?

  init(
    scrollOffset: CGFloat,
    label: String,
    alwaysShowLabel: Bool = false,
    @ViewBuilder leading: @escaping () -> Content? = { Text("") },
    @ViewBuilder trailing: @escaping () -> Content? = { Text("") }
  ) {
    self.scrollOffset = scrollOffset
    self.label = label
    self.alwaysShowLabel = alwaysShowLabel
    self.leading = leading
    self.trailing = trailing
  }

  var body: some View {
    GeometryReader { geo in
      VStack(spacing: Space.small) {
        HStack(spacing: Space.small) {
          leading()
            .frame(maxWidth: geo.size.width / 4, alignment: .leading)
          Text(label)
            .typography(.title3(weight: .bold, color: .black))
            .lineLimit(1)
            .opacity(alwaysShowLabel ? 1 : scrollOffset / 100)
            .frame(maxWidth: geo.size.width / 2, alignment: .center)
          trailing()
            .frame(maxWidth: geo.size.width / 4, alignment: .trailing)
        }
      }
      .padding(
        EdgeInsets(
          top: Space.none,
          leading: Space.medium,
          bottom: Space.small,
          trailing: Space.medium)
      )
      .frame(width: geo.size.width)
      .background(scrollOffset > 1 ? YumeColor.surface2 : Color.black.opacity(0))
    }
  }
}

struct BackAppBar<Content: View>: View {
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
  var scrollOffset: CGFloat
  let label: String
  let alwaysShowLabel: Bool
  let trailing: () -> Content?

  init(
    scrollOffset: CGFloat,
    label: String,
    alwaysShowLabel: Bool = false,
    @ViewBuilder trailing: @escaping () -> Content? = { Text("") }
  ) {
    self.scrollOffset = scrollOffset
    self.label = label
    self.alwaysShowLabel = alwaysShowLabel
    self.trailing = trailing
  }

  var body: some View {
    GeometryReader { geo in
      VStack(spacing: Space.small) {
        HStack(spacing: Space.small) {
          Button {
            presentationMode.wrappedValue.dismiss()
          } label: {
            IconView(icon: Icons.caretLeft)
          }.frame(maxWidth: geo.size.width / 4, alignment: .leading)
          Text(label)
            .typography(.title3(weight: .bold, color: .black))
            .lineLimit(1)
            .opacity(alwaysShowLabel ? 1 : scrollOffset / 100)
            .frame(maxWidth: geo.size.width / 2, alignment: .center)
          trailing()
            .frame(maxWidth: geo.size.width / 4, alignment: .trailing)
        }
      }
      .padding(
        EdgeInsets(
          top: Space.none,
          leading: Space.medium,
          bottom: Space.small,
          trailing: Space.medium)
      )
      .frame(width: geo.size.width)
      .background(scrollOffset > 1 ? YumeColor.surface2 : Color.black.opacity(0))
    }
  }
}

struct AppBar_Previews: PreviewProvider {
    static var previews: some View {
      Group {
        AppBar(scrollOffset: 500, label: "Title")
          .previewDisplayName("App Bar")

        BackAppBar(scrollOffset: 500, label: "Title")
          .previewDisplayName("App Bar with Back")
      }
    }
}
