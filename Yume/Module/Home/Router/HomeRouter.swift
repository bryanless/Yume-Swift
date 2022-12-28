//
//  HomeRouter.swift
//  Yume
//
//  Created by Bryan on 28/12/22.
//

import SwiftUI

class HomeRouter {

  func makeSeeAllView(for animes: [AnimeModel], navigationTitle title: String) -> some View {
    let seeAllUseCase = Injection.init().provideSeeAll(navigationTitle: title, animes: animes)
    let presenter = SeeAllPresenter(seeAllUseCase: seeAllUseCase)
    return SeeAllView(presenter: presenter)
  }

  func makeAnimeDetailView(for anime: AnimeModel) -> some View {
    let animeDetailUseCase = Injection.init().provideAnimeDetail(anime: anime)
    let presenter = AnimeDetailPresenter(animeDetailUseCase: animeDetailUseCase)
    return AnimeDetailView(presenter: presenter)
  }

}
