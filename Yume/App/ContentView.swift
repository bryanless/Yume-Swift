//
//  ContentView.swift
//  Yume
//
//  Created by Bryan on 25/12/22.
//

import Anime
import AnimeDetail
import Core
import Home
import SwiftUI

struct ContentView: View {
  @EnvironmentObject var homePresenter: Home.HomePresenter<
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
  //  @EnvironmentObject var homePresenter: HomePresenter
  @EnvironmentObject var searchPresenter: SearchPresenter
  @EnvironmentObject var favoritePresenter: FavoritePresenter
  @State private var selection: Tab = .home

  init() {
    UITabBar.appearance().isHidden = true
  }

  var body: some View {
    VStack(spacing: 0) {
      TabView(selection: $selection) {
        NavigationStack {
          Home.HomeView<AnimeDetail.AnimeDetailView>(presenter: homePresenter) { anime in
            Router().makeAnimeDetailView(for: anime)
          }
        }.tag(Tab.home)
        //        NavigationStack {
        //          HomeView(presenter: homePresenter)
        //        }.tag(Tab.home)
        NavigationStack {
          SearchView(presenter: searchPresenter)
        }.tag(Tab.search)
        NavigationStack {
          FavoriteView(presenter: favoritePresenter)
        }.tag(Tab.favorite)
        NavigationStack {
          ProfileView()
        }.tag(Tab.profile)
      }
      TabBar(selection: $selection)
    }
  }

}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
