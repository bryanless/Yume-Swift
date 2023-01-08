//
//  ContentView.swift
//  Yume
//
//  Created by Bryan on 25/12/22.
//

import Anime
import AnimeDetail
import Core
import Favorite
import Home
import Profile
import SeeAllAnime
import SwiftUI

struct ContentView: View {
  @EnvironmentObject var homePresenter: Home.HomePresenter<
    Interactor<
      AnimeRankingModuleRequest,
      [AnimeDomainModel],
      GetAnimeRankingRepository<
        GetAnimeRankingLocaleDataSource,
        GetAnimeRankingRemoteDataSource,
        AnimesTransformer>>,
    Interactor<
      AnimeRankingModuleRequest,
      [AnimeDomainModel],
      GetAnimeRankingRepository<
        GetAnimeRankingLocaleDataSource,
        GetAnimeRankingRemoteDataSource,
        AnimesTransformer>>,
    Interactor<
      AnimeRankingModuleRequest,
      [AnimeDomainModel],
      GetAnimeRankingRepository<
        GetAnimeRankingLocaleDataSource,
        GetAnimeRankingRemoteDataSource,
        AnimesTransformer>>,
    Interactor<
      AnimeRankingModuleRequest,
      [AnimeDomainModel],
      GetAnimeRankingRepository<
        GetAnimeRankingLocaleDataSource,
        GetAnimeRankingRemoteDataSource,
        AnimesTransformer>>>
  @EnvironmentObject var favoritePresenter: GetListPresenter<
    Int,
    AnimeDomainModel,
    Interactor<
      Int,
      [AnimeDomainModel],
      GetFavoriteAnimesRepository<
        GetFavoriteAnimeLocaleDataSource,
        AnimesTransformer>>>
  //  @EnvironmentObject var homePresenter: HomePresenter
  @EnvironmentObject var searchPresenter: SearchPresenter
//  @EnvironmentObject var favoritePresenter: FavoritePresenter
  @State private var selection: Tab = .home

  init() {
    UITabBar.appearance().isHidden = true
  }

  var body: some View {
    VStack(spacing: 0) {
      TabView(selection: $selection) {
        NavigationStack {
          Home.HomeView<
            SeeAllAnimeView<AnimeDetail.AnimeDetailView>,
            AnimeDetail.AnimeDetailView>(presenter: homePresenter) { rankingType in
              Router().makeSeeAllAnimeView(for: rankingType) { anime in
                Router().makeAnimeDetailView(for: anime)
              }
            } detailDestination: { anime in
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
          Favorite.FavoriteView(presenter: favoritePresenter) { anime in
            Router().makeAnimeDetailView(for: anime)
          }
        }.tag(Tab.favorite)
        NavigationStack {
          Profile.ProfileView()
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
