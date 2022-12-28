//
//  SeeAllPresenter.swift
//  Yume
//
//  Created by Bryan on 29/12/22.
//

import SwiftUI

class SeeAllPresenter: ObservableObject {

  private let router = SeeAllRouter()
  private let seeAllUseCase: SeeAllUseCase

  @Published var navigationTitle: String
  @Published var animes: [AnimeModel]
  @Published var errorMessage: String = ""
  @Published var loadingState: Bool = false

  init(seeAllUseCase: SeeAllUseCase) {
    self.seeAllUseCase = seeAllUseCase
    navigationTitle = seeAllUseCase.getNavigationTitle()
    animes = seeAllUseCase.getAnimes()
  }

  func linkBuilder<Content: View>(
    for anime: AnimeModel,
    @ViewBuilder content: () -> Content
  ) -> some View {
    NavigationLink(
    destination: router.makeAnimeDetailView(for: anime)) { content() }
  }

}
