//
//  HomeView.swift
//  Yume
//
//  Created by Bryan on 28/12/22.
//

import SwiftUI

struct HomeView: View {
  @ObservedObject var presenter: HomePresenter
  @State var scrollOffset = CGFloat.zero

  var body: some View {
    ZStack {
      if presenter.loadingState {
        ProgressIndicator()
          .background(YumeColor.background)
      } else {
        NavigationStack {
          ZStack(alignment: .top) {
            ObservableScrollView(scrollOffset: $scrollOffset, showsIndicators: false) { _ in
              LazyVStack(spacing: Space.large) {
                header
                topAiringAnime
                topUpcomingAnime
                popularAnime
                topAllAnime
              }.padding(
                EdgeInsets(
                  top: 40,
                  leading: Space.none,
                  bottom: Space.medium,
                  trailing: Space.none)
              )
            }
            AppBar(scrollOffset: scrollOffset, label: "Home")
          }
          .background(YumeColor.background)
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
  var header: some View {
    HStack {
      Text("Home")
        .typography(.largeTitle(weight: .bold, color: YumeColor.onBackground))
      Spacer()
    }.padding(.horizontal, Space.medium)
  }

  var topAiringAnime: some View {
    VStack(spacing: Space.small) {
      HStack(spacing: Space.small) {
        Text("Now Airing")
          .typography(.headline(color: YumeColor.onBackground))
        Spacer()
        self.presenter.seeAllLinkBuilder(
          for: self.presenter.topAiringAnimes,
          navigationTitle: "Now Airing"
        ) {
          Text("See All")
            .typography(.subheadline(color: YumeColor.primary))
        }
      }.padding(.horizontal, Space.medium)

      ScrollView(.horizontal, showsIndicators: false) {
        LazyHStack(spacing: Space.small) {
          ForEach(self.presenter.topAiringAnimes) { anime in
            self.presenter.animeDetailLinkBuilder(for: anime) {
              AnimeItem(anime: anime)
            }.buttonStyle(.plain)
          }
        }.padding(.horizontal, Space.medium)
      }
    }
  }

  var topUpcomingAnime: some View {
    VStack(spacing: Space.small) {
      HStack(spacing: Space.small) {
        Text("Upcoming")
          .typography(.headline(color: YumeColor.onBackground))
        Spacer()
        self.presenter.seeAllLinkBuilder(
          for: self.presenter.topUpcomingAnimes,
          navigationTitle: "Upcoming"
        ) {
          Text("See All")
            .typography(.subheadline(color: YumeColor.primary))
        }
      }.padding(.horizontal, Space.medium)

      ScrollView(.horizontal, showsIndicators: false) {
        LazyHStack(spacing: Space.small) {
          ForEach(self.presenter.topUpcomingAnimes) { anime in
            self.presenter.animeDetailLinkBuilder(for: anime) {
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
          .typography(.headline(color: YumeColor.onBackground))
        Spacer()
        self.presenter.seeAllLinkBuilder(
          for: self.presenter.popularAnimes,
          navigationTitle: "Most Popular"
        ) {
          Text("See All")
            .typography(.subheadline(color: YumeColor.primary))
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

  var topAllAnime: some View {
    VStack(spacing: Space.small) {
      HStack(spacing: Space.small) {
        Text("Top Rated")
          .typography(.headline(color: YumeColor.onBackground))
        Spacer()
        self.presenter.seeAllLinkBuilder(
          for: self.presenter.topAllAnimes,
          navigationTitle: "Top Rated"
        ) {
          Text("See All")
            .typography(.subheadline(color: YumeColor.primary))
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
