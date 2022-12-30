//
//  FavoriteView.swift
//  Yume
//
//  Created by Bryan on 29/12/22.
//

import SwiftUI

struct FavoriteView: View {
  @ObservedObject var presenter: FavoritePresenter
  @State var scrollOffset = CGFloat.zero

  var body: some View {
    ZStack {
      if presenter.viewState == .unknown {
        ProgressIndicator()
          .onAppear {
            self.presenter.getFavoriteAnimes()
          }
      } else {
        NavigationStack {
          if self.presenter.favoriteAnimes.isEmpty {
            VStack(alignment: .leading) {
              Text("Favorites")
                .typography(.largeTitle(weight: .bold))
              NothingFound(label: "No favorite anime")
                .background(YumeColor.background)
                .onAppear {
                  self.presenter.getFavoriteAnimes()
                }
            }
            .padding(
              EdgeInsets(
                top: 40,
                leading: Space.medium,
                bottom: Space.medium,
                trailing: Space.medium)
            )
            .background(YumeColor.background)
          } else {
            ZStack(alignment: .top) {
              ObservableScrollView(scrollOffset: $scrollOffset, showsIndicators: false) { _ in
                LazyVStack(alignment: .leading, spacing: Space.small) {
                  Text("Favorites")
                    .typography(.largeTitle(weight: .bold))
                  ForEach(self.presenter.favoriteAnimes) { anime in
                    self.presenter.linkBuilder(for: anime) {
                      AnimeCardItem(anime: anime)
                    }.buttonStyle(.plain)
                  }
                }.padding(
                  EdgeInsets(
                    top: 40,
                    leading: Space.medium,
                    bottom: Space.medium,
                    trailing: Space.medium)
                )
              }
              .background(YumeColor.background)
              .onAppear {
                self.presenter.getFavoriteAnimes()
              }
              AppBar(scrollOffset: scrollOffset, label: "Favorite")
            }
          }
        }
      }
    }
  }
}
