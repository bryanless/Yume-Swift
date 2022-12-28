//
//  SeeAllInteractor.swift
//  Yume
//
//  Created by Bryan on 29/12/22.
//

import Foundation
import Combine

protocol SeeAllUseCase {

  func getNavigationTitle() -> String
  func getAnimes() -> [AnimeModel]

}

class SeeAllInteractor: SeeAllUseCase {

  private let repository: AnimeRepositoryProtocol
  private let navigationTitle: String
  private let animes: [AnimeModel]

  required init(
    repository: AnimeRepositoryProtocol,
    navigationTitle: String ,
    animes: [AnimeModel]
  ) {
    self.repository = repository
    self.navigationTitle = navigationTitle
    self.animes = animes
  }

  func getNavigationTitle() -> String {
    return navigationTitle
  }

  func getAnimes() -> [AnimeModel] {
    return animes
  }

}
