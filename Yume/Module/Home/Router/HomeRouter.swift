//
//  HomeRouter.swift
//  Yume
//
//  Created by Bryan on 28/12/22.
//

import SwiftUI

class HomeRouter {

  func makeAnimeDetailView(for anime: AnimeModel) -> some View {
    let animeDetailUseCase = Injection.init().provideAnimeDetail(anime: anime)
    let presenter = AnimeDetailPresenter(animeDetailUseCase: animeDetailUseCase)
    return AnimeDetailView(presenter: presenter)
  }

}
