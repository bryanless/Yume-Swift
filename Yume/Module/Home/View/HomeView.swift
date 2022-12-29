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
        VStack {
          ProgressView()
          Text("Loading")
        }
      } else {
        NavigationStack {
          ZStack(alignment: .top) {
            ObservableScrollView(scrollOffset: $scrollOffset) { _ in
              LazyVStack(spacing: Space.large) {
                header
                popularAnime
                topRatedAnime
              }.padding(.vertical, Space.medium)
            }
            appBar(scrollOffset: scrollOffset)
          }
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
  func appBar(scrollOffset: CGFloat) -> some View {
    return GeometryReader { geo in
      ZStack {
          HStack {
            Text("Home")
              .typography(.title3(weight: .bold, color: .black))
          }
          .padding(
            EdgeInsets(
              top: Space.none,
              leading: Space.medium,
              bottom: Space.small,
              trailing: Space.medium)
          )
          .frame(width: geo.size.width)
        }
      .background(Material.thinMaterial)
      .opacity(scrollOffset / 10)
    }
  }

  var header: some View {
    HStack {
      Text("Home")
        .typography(.largeTitle(weight: .bold, color: .black))
      Spacer()
    }.padding(.horizontal, Space.medium)
  }

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
