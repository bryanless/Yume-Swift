//
//  HomePresenter.swift
//  Yume
//
//  Created by Bryan on 28/12/22.
//

import SwiftUI
import Combine

class HomePresenter: ObservableObject {
  private var cancellables: Set<AnyCancellable> = []

  private let router = HomeRouter()
  private let homeUseCase: HomeUseCase

  @Published var animes: [AnimeModel] = []
  @Published var errorMessage: String = ""
  @Published var loadingState: Bool = false

  init(homeUseCase: HomeUseCase) {
    self.homeUseCase = homeUseCase
  }

  func getTopAllAnimes() {
    loadingState = true
    homeUseCase.getTopAllAnimes()
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure:
          self.errorMessage = String(describing: completion)
          print(self.errorMessage)
        case .finished:
          self.loadingState = false
        }
      }, receiveValue: { animes in
        self.animes = animes
      })
      .store(in: &cancellables)
  }

  func linkBuilder<Content: View>(
    for anime: AnimeModel,
    @ViewBuilder content: () -> Content
  ) -> some View {
    NavigationLink(
    destination: router.makeAnimeDetailView(for: anime)) { content() }
  }

}
