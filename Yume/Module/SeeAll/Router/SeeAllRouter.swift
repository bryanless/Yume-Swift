//
//  SeeAllRouter.swift
//  Yume
//
//  Created by Bryan on 29/12/22.
//

import SwiftUI

class SeeAllRouter {

  func makeAnimeDetailView(for anime: AnimeModel) -> some View {
    let animeDetailUseCase = Injection.init().provideAnimeDetail(anime: anime)
    let presenter = AnimeDetailPresenter(animeDetailUseCase: animeDetailUseCase)
    return AnimeDetailView(presenter: presenter)
  }

}
