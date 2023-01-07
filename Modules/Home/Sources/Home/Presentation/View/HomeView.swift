//
//  HomeView.swift
//  
//
//  Created by Bryan on 07/01/23.
//

import Anime
import Common
import Core
import SwiftUI

public struct HomeView: View {
  @ObservedObject var presenter: HomePresenter<
    Interactor<
      AnimeRankingModuleRequest,
      [AnimeDomainModel],
      GetAnimesRepository<
        GetTopAiringAnimesLocaleDataSource,
        GetAnimeRankingRemoteDataSource,
        AnimesTransformer>>,
    Interactor<
      AnimeRankingModuleRequest,
      [AnimeDomainModel],
      GetAnimesRepository<
        GetTopUpcomingAnimesLocaleDataSource,
        GetAnimeRankingRemoteDataSource,
        AnimesTransformer>>,
    Interactor<
      AnimeRankingModuleRequest,
      [AnimeDomainModel],
      GetAnimesRepository<
        GetPopularAnimesLocaleDataSource,
        GetAnimeRankingRemoteDataSource,
        AnimesTransformer>>,
    Interactor<
      AnimeRankingModuleRequest,
      [AnimeDomainModel],
      GetAnimesRepository<
        GetTopAllAnimesLocaleDataSource,
        GetAnimeRankingRemoteDataSource,
        AnimesTransformer>>>
  @State var scrollOffset: CGFloat

  public init(
    presenter: HomePresenter<
    Interactor<
    AnimeRankingModuleRequest,
    [AnimeDomainModel],
    GetAnimesRepository<
    GetTopAiringAnimesLocaleDataSource,
    GetAnimeRankingRemoteDataSource,
    AnimesTransformer>>,
    Interactor<
    AnimeRankingModuleRequest,
    [AnimeDomainModel],
    GetAnimesRepository<
    GetTopUpcomingAnimesLocaleDataSource,
    GetAnimeRankingRemoteDataSource,
    AnimesTransformer>>,
    Interactor<
    AnimeRankingModuleRequest,
    [AnimeDomainModel],
    GetAnimesRepository<
    GetPopularAnimesLocaleDataSource,
    GetAnimeRankingRemoteDataSource,
    AnimesTransformer>>,
    Interactor<
    AnimeRankingModuleRequest,
    [AnimeDomainModel],
    GetAnimesRepository<
    GetTopAllAnimesLocaleDataSource,
    GetAnimeRankingRemoteDataSource,
    AnimesTransformer>>>,
    scrollOffset: CGFloat = CGFloat.zero
  ) {
    self.presenter = presenter
    self.scrollOffset = scrollOffset
  }

  public var body: some View {
    ZStack {
      if presenter.isLoading {
        ProgressIndicator()
          .background(YumeColor.background)
      } else if presenter.isError {
        Text(presenter.errorMessage)
          .background(YumeColor.background)
      } else {
        content
      }
    }.onAppear {
      if presenter.topAiringAnimeList.isEmpty
          || presenter.topUpcomingAnimeList.isEmpty
          || presenter.popularAnimeList.isEmpty
          || presenter.topAllAnimeList.isEmpty {
        presenter.setupHomeView()
      }
    }
  }
}

extension HomeView {
  var content: some View {
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
    }.background(YumeColor.background)
  }

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
        //        self.presenter.seeAllLinkBuilder(
        //          for: self.presenter.topAiringAnimes,
        //          navigationTitle: "Now Airing"
        //        ) {
        Text("See All")
          .typography(.subheadline(color: YumeColor.primary))
        //        }
      }.padding(.horizontal, Space.medium)

      ScrollView(.horizontal, showsIndicators: false) {
        LazyHStack(spacing: Space.small) {
          ForEach(presenter.topAiringAnimeList.prefix(10)) { anime in
            //            self.presenter.animeDetailLinkBuilder(for: anime) {
            AnimeItem(anime: anime)
            //            }.buttonStyle(.plain)
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
        //        self.presenter.seeAllLinkBuilder(
        //          for: self.presenter.topUpcomingAnimes,
        //          navigationTitle: "Upcoming"
        //        ) {
        Text("See All")
          .typography(.subheadline(color: YumeColor.primary))
        //        }
      }.padding(.horizontal, Space.medium)

      ScrollView(.horizontal, showsIndicators: false) {
        LazyHStack(spacing: Space.small) {
          ForEach(presenter.topUpcomingAnimeList.prefix(10)) { anime in
            //            self.presenter.animeDetailLinkBuilder(for: anime) {
            AnimeItem(anime: anime)
            //            }.buttonStyle(.plain)
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
        //        self.presenter.seeAllLinkBuilder(
        //          for: self.presenter.popularAnimes,
        //          navigationTitle: "Most Popular"
        //        ) {
        Text("See All")
          .typography(.subheadline(color: YumeColor.primary))
        //        }
      }.padding(.horizontal, Space.medium)

      ScrollView(.horizontal, showsIndicators: false) {
        LazyHStack(spacing: Space.small) {
          ForEach(presenter.popularAnimeList.prefix(10)) { anime in
            //            self.presenter.animeDetailLinkBuilder(for: anime) {
            AnimeItem(anime: anime)
            //            }.buttonStyle(.plain)
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
        //        self.presenter.seeAllLinkBuilder(
        //          for: self.presenter.topAllAnimes,
        //          navigationTitle: "Top Rated"
        //        ) {
        Text("See All")
          .typography(.subheadline(color: YumeColor.primary))
        //        }
      }.padding(.horizontal, Space.medium)

      ScrollView(.horizontal, showsIndicators: false) {
        LazyHStack(spacing: Space.small) {
          ForEach(presenter.topAllAnimeList.prefix(10)) { anime in
            //            self.presenter.animeDetailLinkBuilder(for: anime) {
            AnimeItem(anime: anime)
            //            }.buttonStyle(.plain)
          }
        }.padding(.horizontal, Space.medium)
      }
    }
  }
}
