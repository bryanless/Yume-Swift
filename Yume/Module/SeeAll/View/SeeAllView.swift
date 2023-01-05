//
//  SeeAllView.swift
//  Yume
//
//  Created by Bryan on 29/12/22.
//

import SwiftUI

struct SeeAllView: View {
  @ObservedObject var presenter: SeeAllPresenter
  @State var scrollOffset = CGFloat.zero

  var body: some View {
    ZStack {
      if presenter.loadingState {
        ProgressIndicator()
      } else {
        NavigationStack {
          ZStack(alignment: .top) {
            ObservableScrollView(scrollOffset: $scrollOffset, showsIndicators: false) { _ in
              LazyVStack(spacing: Space.small) {
                ForEach(self.presenter.animes.prefix(20)) { anime in
                  self.presenter.linkBuilder(for: anime) {
                    AnimeCardItem(anime: anime)
                  }.buttonStyle(.plain)
                }
              }
              .padding(
                EdgeInsets(
                  top: 56,
                  leading: Space.medium,
                  bottom: Space.medium,
                  trailing: Space.medium)
              )
            }.background(YumeColor.background)

            BackAppBar(scrollOffset: scrollOffset, label: self.presenter.navigationTitle, alwaysShowLabel: true)
          }
        }
      }
    }.toolbar(.hidden)
  }
}
