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
      if presenter.uiState == .unknown {
        VStack {
          ProgressView()
          Text("Loading")
        }.onAppear {
          self.presenter.getFavoriteAnimes()
        }
      } else {
        NavigationStack {
          if self.presenter.favoriteAnimes.isEmpty {
            Text("No favorite anime")
              .typography(.body(color: YumeColor.onSurfaceVariant))
              .navigationTitle("Favorites")
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
            }.navigationTitle("Favorites")
              .onAppear {
                self.presenter.getFavoriteAnimes()
              }
          }
        }
      }
    }
  }
}
