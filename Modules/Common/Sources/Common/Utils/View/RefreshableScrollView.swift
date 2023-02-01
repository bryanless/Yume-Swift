//
//  RefreshableScrollView.swift
//  
//
//  Created by Bryan on 01/02/23.
//

import Core
import SwiftUI

// A ScrollView wrapper that tracks scroll offset changes.
public struct RefreshableScrollView<Content>: View where Content: View {

  @Binding var scrollOffset: CGFloat
  @Binding var isRefreshing: Bool
  let refreshLabel: String
  let onRefresh: () -> Void
  let showsIndicators: Bool
  let content: (ScrollViewProxy) -> Content

  public init(
    scrollOffset: Binding<CGFloat>,
    showsIndicators: Bool = true,
    refreshLabel: String = "",
    isRefreshing: Binding<Bool>,
    onRefresh: @escaping () -> Void,
    @ViewBuilder content: @escaping (ScrollViewProxy) -> Content
  ) {
    _scrollOffset = scrollOffset
    self.showsIndicators = showsIndicators
    self.refreshLabel = refreshLabel
    _isRefreshing = isRefreshing
    self.onRefresh = onRefresh
    self.content = content
  }

  public var body: some View {
    ObservableScrollView(scrollOffset: $scrollOffset, content: content)
      .onAppear {
        UIRefreshControl.appearance().tintColor = UIColor(YumeColor.onSurfaceVariant)
        UIRefreshControl.appearance().attributedTitle = NSAttributedString(string: refreshLabel)
      }
      .refreshable {
        onRefresh()
        await refreshing()
      }
  }
}

extension RefreshableScrollView {
  func refreshing() async {
    while isRefreshing {}
  }
}
