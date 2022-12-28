//
//  AnimeDetailPresenter.swift
//  Yume
//
//  Created by Bryan on 28/12/22.
//

import Foundation

class AnimeDetailPresenter: ObservableObject {

  private let animeDetailUseCase: AnimeDetailUseCase

  @Published var anime: AnimeModel
  @Published var errorMessage: String = ""
  @Published var loadingState: Bool = false

  init(animeDetailUseCase: AnimeDetailUseCase) {
    self.animeDetailUseCase = animeDetailUseCase
    anime = animeDetailUseCase.getAnime()
  }

}
