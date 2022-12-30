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
          ObservableScrollView(scrollOffset: $scrollOffset, showsIndicators: false) { _ in
            LazyVStack(spacing: Space.small) {
              ForEach(self.presenter.animes) { anime in
                self.presenter.linkBuilder(for: anime) {
                  AnimeCardItem(anime: anime)
                }.buttonStyle(.plain)
              }
            }.padding(Space.medium)
          }.background(YumeColor.background)
        }
      }
    }.toolbar(.hidden)
  }
}
