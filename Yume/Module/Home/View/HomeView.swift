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
            LazyVStack(spacing: Space.large) {
              nowAiringAnime
              popularAnime
            }.padding(.vertical, Space.medium)
          }.navigationTitle("Home")
        }.onAppear {
          if self.presenter.topAllAnimes.isEmpty
              || self.presenter.popularAnimes.isEmpty {
            self.presenter.setupHomeView()
          }
        }
      }
    }
  }
}

extension HomeView {
  var nowAiringAnime: some View {
    VStack(spacing: Space.small) {
      HStack(spacing: Space.small) {
        Text("Now Airing")
          .typography(.headline())
        Spacer()
        Text("View all")
          .typography(.subheadline())
      }.padding(.horizontal, Space.medium)

      ScrollView(.horizontal, showsIndicators: false) {
        LazyHStack(spacing: Space.small) {
          ForEach(self.presenter.topAllAnimes) { anime in
            self.presenter.linkBuilder(for: anime) {
              AnimeItem(anime: anime)
            }.buttonStyle(.plain)
          }
        }.padding(.horizontal, Space.medium)
      }
    }
  }

  var popularAnime: some View {
    VStack(spacing: Space.small) {
      HStack(spacing: Space.small) {
        Text("Most Popular")
          .typography(.headline())
        Spacer()
        Text("View all")
          .typography(.subheadline())
      }.padding(.horizontal, Space.medium)

      ScrollView(.horizontal, showsIndicators: false) {
        LazyHStack(spacing: Space.small) {
          ForEach(self.presenter.popularAnimes) { anime in
            self.presenter.linkBuilder(for: anime) {
              AnimeItem(anime: anime)
            }.buttonStyle(.plain)
          }
        }.padding(.horizontal, Space.medium)
      }
    }
  }
}
