//
//  YumeApp.swift
//  Yume
//
//  Created by Bryan on 25/12/22.
//

import Anime
import Core
import Home
import SwiftUI

@main
struct YumeApp: App {
  @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

  var body: some Scene {
    let topAiringAnimeUseCase: Interactor<
      AnimeRankingModuleRequest,
      [AnimeDomainModel],
      GetAnimesRepository<
        GetTopAiringAnimesLocaleDataSource,
        GetAnimeRankingRemoteDataSource,
        AnimesTransformer>
    > = Injection.init().provideTopAiringAnime()
    let topUpcomingAnimeUseCase: Interactor<
      AnimeRankingModuleRequest,
      [AnimeDomainModel],
      GetAnimesRepository<
        GetTopUpcomingAnimesLocaleDataSource,
        GetAnimeRankingRemoteDataSource,
        AnimesTransformer>
    > = Injection.init().provideTopUpcomingAnime()
    let popularAnimeUseCase: Interactor<
      AnimeRankingModuleRequest,
      [AnimeDomainModel],
      GetAnimesRepository<
        GetPopularAnimesLocaleDataSource,
        GetAnimeRankingRemoteDataSource,
        AnimesTransformer>
    > = Injection.init().providePopularAnime()
    let topAllAnimeUseCase: Interactor<
      AnimeRankingModuleRequest,
      [AnimeDomainModel],
      GetAnimesRepository<
        GetTopAllAnimesLocaleDataSource,
        GetAnimeRankingRemoteDataSource,
        AnimesTransformer>
    > = Injection.init().provideTopAllAnime()
    //    let homeUseCase = Injection.init().provideHome()
    let searchUseCase = Injection.init().provideSearch()
    let favoriteUseCase = Injection.init().provideFavorite()

    let homePresenter = Home.HomePresenter(
      topAiringAnimeUseCase: topAiringAnimeUseCase,
      topUpcomingAnimeUseCase: topUpcomingAnimeUseCase,
      popularAnimeUseCase: popularAnimeUseCase,
      topAllAnimeUseCase: topAllAnimeUseCase)
    //    let homePresenter = HomePresenter(homeUseCase: homeUseCase)
    let searchPresenter = SearchPresenter(searchUseCase: searchUseCase)
    let favoritePresenter = FavoritePresenter(favoriteUseCase: favoriteUseCase)

    WindowGroup {
      ContentView()
        .environmentObject(homePresenter)
      //        .environmentObject(homePresenter)
        .environmentObject(searchPresenter)
        .environmentObject(favoritePresenter)
    }
  }
}
