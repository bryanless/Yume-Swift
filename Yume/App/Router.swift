//
//  Router.swift
//  Yume
//
//  Created by Bryan on 08/01/23.
//

import Anime
import AnimeDetail
import Core
import SeeAllAnime
import SwiftUI

class Router {
  func makeAnimeDetailView(for anime: AnimeDomainModel) -> AnimeDetailView {

    let animeUseCase: Interactor<
      AnimeRequest,
      AnimeDomainModel,
      GetAnimeRepository<
        GetAnimeLocaleDataSource,
        GetAnimeRemoteDataSource,
        AnimeTransformer>> = Injection.init().provideAnime()

    let favoriteUseCase: Interactor<
      Int,
      AnimeDomainModel,
      UpdateFavoriteAnimeRepository<
        GetFavoriteAnimeLocaleDataSource,
        AnimeDataTransformer>> = Injection.init().provideUpdateFavoriteAnime()

    let presenter = AnimePresenter(animeUseCase: animeUseCase, favoriteUseCase: favoriteUseCase)

    return AnimeDetailView(presenter: presenter, anime: anime)

  }

  func makeSeeAllAnimeView(
    for rankingType: String,
    detailDestination: @escaping ((_ anime: AnimeDomainModel) -> AnimeDetailView)) -> SeeAllAnimeView<AnimeDetailView> {
    var navigationTitle: String

    switch rankingType {
    case "airing":
      navigationTitle = "now_airing_title"
    case "upcoming":
      navigationTitle = "upcoming_title"
    case "bypopularity":
      navigationTitle = "most_popular_title"
    default:
      // All
      navigationTitle = "top_rated_title"
    }

    let seeAllAnimeUseCase: Interactor<
      AnimeRankingModuleRequest,
      [AnimeDomainModel],
      GetAnimeRankingRepository<
        GetAnimeRankingLocaleDataSource,
        GetAnimeRankingRemoteDataSource,
        AnimesTransformer>> = Injection.init().provideAnimeRanking()

    let presenter = GetListPresenter(useCase: seeAllAnimeUseCase)

    return SeeAllAnimeView<AnimeDetailView>(
      presenter: presenter,
      rankingType: rankingType,
      navigationTitle: navigationTitle,
      detailDestination: detailDestination
    )
  }
}
