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

let injection = Injection.init()

// Home
let topAiringAnimeUseCase: Interactor<
  AnimeRankingRequest,
  [AnimeDomainModel],
  GetAnimeRankingRepository<
    GetAnimeRankingLocaleDataSource,
    GetAnimeRankingRemoteDataSource,
    AnimesTransformer>> = injection.provideAnimeRanking()
let topUpcomingAnimeUseCase: Interactor<
  AnimeRankingRequest,
  [AnimeDomainModel],
  GetAnimeRankingRepository<
    GetAnimeRankingLocaleDataSource,
    GetAnimeRankingRemoteDataSource,
    AnimesTransformer>> = injection.provideAnimeRanking()
let popularAnimeUseCase: Interactor<
  AnimeRankingRequest,
  [AnimeDomainModel],
  GetAnimeRankingRepository<
    GetAnimeRankingLocaleDataSource,
    GetAnimeRankingRemoteDataSource,
    AnimesTransformer>> = injection.provideAnimeRanking()
let topAllAnimeUseCase: Interactor<
  AnimeRankingRequest,
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
    GetAnimeListLocaleDataSource,
    GetAnimeListRemoteDataSource,
    AnimesTransformer>> = injection.provideSearchAnime()
let topFavoriteAnimeUseCase: Interactor<
  AnimeRankingRequest,
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

@main
struct YumeApp: App {

  let homePresenter = HomePresenter(
    topAiringAnimeUseCase: topAiringAnimeUseCase,
    topUpcomingAnimeUseCase: topUpcomingAnimeUseCase,
    popularAnimeUseCase: popularAnimeUseCase,
    topAllAnimeUseCase: topAllAnimeUseCase)
  let searchPresenter = SearchPresenter(
    searchAnimeUseCase: searchAnimeUseCase,
    topFavoriteAnimeUseCase: topFavoriteAnimeUseCase)
  let favoritePresenter = GetListPresenter(useCase: favoriteAnimeUseCase)

  var body: some Scene {
    WindowGroup {
      ContentView()
        .environmentObject(homePresenter)
        .environmentObject(searchPresenter)
        .environmentObject(favoritePresenter)
    }
  }
}
