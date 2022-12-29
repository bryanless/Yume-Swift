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
              popularAnime
              topRatedAnime
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
  var popularAnime: some View {
    VStack(spacing: Space.small) {
      HStack(spacing: Space.small) {
        Text("Most Popular")
          .typography(.headline())
        Spacer()
        self.presenter.seeAllLinkBuilder(
          for: self.presenter.popularAnimes,
          navigationTitle: "Most Popular"
        ) {
          Text("See All")
            .typography(.subheadline())
        }
      }.padding(.horizontal, Space.medium)

      ScrollView(.horizontal, showsIndicators: false) {
        LazyHStack(spacing: Space.small) {
          ForEach(self.presenter.popularAnimes) { anime in
            self.presenter.animeDetailLinkBuilder(for: anime) {
              AnimeItem(anime: anime)
            }.buttonStyle(.plain)
          }
        }.padding(.horizontal, Space.medium)
      }
    }
  }

  var topRatedAnime: some View {
    VStack(spacing: Space.small) {
      HStack(spacing: Space.small) {
        Text("Top Rated")
          .typography(.headline())
        Spacer()
        self.presenter.seeAllLinkBuilder(
          for: self.presenter.topAllAnimes,
          navigationTitle: "Now Airing"
        ) {
          Text("See All")
            .typography(.subheadline())
        }
      }.padding(.horizontal, Space.medium)

      ScrollView(.horizontal, showsIndicators: false) {
        LazyHStack(spacing: Space.small) {
          ForEach(self.presenter.topAllAnimes) { anime in
            self.presenter.animeDetailLinkBuilder(for: anime) {
              AnimeItem(anime: anime)
            }.buttonStyle(.plain)
          }
        }.padding(.horizontal, Space.medium)
      }
    }
  }

}
