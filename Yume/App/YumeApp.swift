//
//  YumeApp.swift
//  Yume
//
//  Created by Bryan on 25/12/22.
//

import Anime
import Core
import Home
import Search
import SwiftUI

@main
struct YumeApp: App {
  @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

  var body: some Scene {
    let injection = Injection.init()

    // Home
    let topAiringAnimeUseCase: Interactor<
      AnimeRankingModuleRequest,
      [AnimeDomainModel],
      GetAnimeRankingRepository<
        GetAnimeRankingLocaleDataSource,
        GetAnimeRankingRemoteDataSource,
        AnimesTransformer>> = injection.provideAnimeRanking()
    let topUpcomingAnimeUseCase: Interactor<
      AnimeRankingModuleRequest,
      [AnimeDomainModel],
      GetAnimeRankingRepository<
        GetAnimeRankingLocaleDataSource,
        GetAnimeRankingRemoteDataSource,
        AnimesTransformer>> = injection.provideAnimeRanking()
    let popularAnimeUseCase: Interactor<
      AnimeRankingModuleRequest,
      [AnimeDomainModel],
      GetAnimeRankingRepository<
        GetAnimeRankingLocaleDataSource,
        GetAnimeRankingRemoteDataSource,
        AnimesTransformer>> = injection.provideAnimeRanking()
    let topAllAnimeUseCase: Interactor<
      AnimeRankingModuleRequest,
      [AnimeDomainModel],
      GetAnimeRankingRepository<
        GetAnimeRankingLocaleDataSource,
        GetAnimeRankingRemoteDataSource,
        AnimesTransformer>> = injection.provideAnimeRanking()

    // Search
    let searchAnimeUseCase: Interactor<
      AnimeListRequest,
      [AnimeDomainModel],
      SearchAnimeRepository<
        GetAnimeListRemoteDataSource,
        AnimesTransformer>> = injection.provideSearchAnime()
    let topFavoriteAnimeUseCase: Interactor<
      AnimeRankingModuleRequest,
      [AnimeDomainModel],
      GetAnimeRankingRepository<
        GetAnimeRankingLocaleDataSource,
        GetAnimeRankingRemoteDataSource,
        AnimesTransformer>> = injection.provideAnimeRanking()

    // Favorite
    let favoriteAnimeUseCase: Interactor<
      Int,
      [AnimeDomainModel],
      GetFavoriteAnimesRepository<
        GetFavoriteAnimeLocaleDataSource,
        AnimesTransformer>> = injection.provideFavoriteAnime()

    let homePresenter = Home.HomePresenter(
      topAiringAnimeUseCase: topAiringAnimeUseCase,
      topUpcomingAnimeUseCase: topUpcomingAnimeUseCase,
      popularAnimeUseCase: popularAnimeUseCase,
      topAllAnimeUseCase: topAllAnimeUseCase)
    let searchPresenter = Search.SearchPresenter(
      searchAnimeUseCase: searchAnimeUseCase,
      topFavoriteAnimeUseCase: topFavoriteAnimeUseCase)
    let favoritePresenter = GetListPresenter(useCase: favoriteAnimeUseCase)

    WindowGroup {
      ContentView()
        .environmentObject(homePresenter)
        .environmentObject(searchPresenter)
        .environmentObject(favoritePresenter)
    }
  }
}
