//
//  FavoriteView.swift
//  Yume
//
//  Created by Bryan on 29/12/22.
//

import SwiftUI

struct FavoriteView: View {
  @ObservedObject var presenter: FavoritePresenter

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
            NothingFound(label: "No favorite anime")
              .background(YumeColor.background)
              .onAppear {
                self.presenter.getFavoriteAnimes()
              }
          } else {
            ScrollView(.vertical, showsIndicators: false) {
              LazyVStack(spacing: Space.small) {
                ForEach(self.presenter.favoriteAnimes) { anime in
                  self.presenter.linkBuilder(for: anime) {
                    AnimeCardItem(anime: anime)
                  }.buttonStyle(.plain)
                }
              }.padding(Space.medium)
            }
            .background(YumeColor.background)
            .onAppear {
              self.presenter.getFavoriteAnimes()
            }
          }
        }
      }
    }
  }
}
