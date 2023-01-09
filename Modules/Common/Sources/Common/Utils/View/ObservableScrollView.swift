//
//  ObservableScrollView.swift
//  Yume
//
//  Created by Bryan on 29/12/22.
//

import SwiftUI

// Credit: https://swiftuirecipes.com/blog/swiftui-scrollview-scroll-offset
// Simple preference that observes a CGFloat.
struct ScrollViewOffsetPreferenceKey: PreferenceKey {
  static var defaultValue = CGFloat.zero

  static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
    value += nextValue()
  }
}

// A ScrollView wrapper that tracks scroll offset changes.
public struct ObservableScrollView<Content>: View where Content: View {
  @Namespace var scrollSpace

  @Binding var scrollOffset: CGFloat
  let showsIndicators: Bool
  let content: (ScrollViewProxy) -> Content

  public init(
    scrollOffset: Binding<CGFloat>,
    showsIndicators: Bool = true,
    @ViewBuilder content: @escaping (ScrollViewProxy) -> Content
  ) {
    _scrollOffset = scrollOffset
    self.showsIndicators = showsIndicators
    self.content = content
  }

  public var body: some View {
    ScrollView(showsIndicators: showsIndicators) {
      ScrollViewReader { proxy in
        content(proxy)
          .background(GeometryReader { geo in
            let offset = -geo.frame(in: .named(scrollSpace)).minY
            Color.clear
              .preference(key: ScrollViewOffsetPreferenceKey.self,
                          value: offset)
          })
      }
    }
    .coordinateSpace(name: scrollSpace)
    .onPreferenceChange(ScrollViewOffsetPreferenceKey.self) { value in
      scrollOffset = value
    }
  }
}
