//
//  HomeView.swift
//  Yume
//
//  Created by Bryan on 28/12/22.
//

import SwiftUI

struct HomeView: View {
  @ObservedObject var presenter: HomePresenter

  var body: some View {
    ZStack {
      if presenter.loadingState {
        VStack {
          ProgressView()
          Text("Loading")
        }
      } else {
        NavigationStack {
          ScrollView(.vertical, showsIndicators: false) {
            ScrollView(.horizontal, showsIndicators: false) {
              LazyHStack(spacing: Space.small) {
                ForEach(self.presenter.animes) { anime in
                  self.presenter.linkBuilder(for: anime) {
                    AnimeItem(anime: anime)
                  }.buttonStyle(.plain)
                }
              }
            }
          }.navigationTitle("Home")
        }.onAppear {
          if self.presenter.animes.count == 0 {
            self.presenter.getTopAllAnimes()
          }
        }
      }
    }
  }
}
