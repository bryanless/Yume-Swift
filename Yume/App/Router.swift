//
//  Router.swift
//  Yume
//
//  Created by Bryan on 08/01/23.
//

import Anime
import AnimeDetail
import Core
import SwiftUI

class Router {
  func makeAnimeDetailView(for anime: AnimeDomainModel) -> AnimeDetail.AnimeDetailView {

    let animeUseCase: Interactor<
      Int,
      AnimeDomainModel,
      GetAnimeRepository<
        GetAnimeLocaleDataSource,
        AnimeTransformer>> = Injection.init().provideAnime()

    let favoriteUseCase: Interactor<
      Int,
      AnimeDomainModel,
      UpdateFavoriteAnimeRepository<
        GetFavoriteAnimeLocaleDataSource,
        AnimeTransformer>> = Injection.init().provideUpdateFavoriteAnime()

    let presenter = AnimePresenter(animeUseCase: animeUseCase, favoriteUseCase: favoriteUseCase)

    return AnimeDetail.AnimeDetailView(presenter: presenter, anime: anime)

  }
}
