//
//  Injection.swift
//  Yume
//
//  Created by Bryan on 28/12/22.
//

import Foundation
import RealmSwift

final class Injection: NSObject {

  private func provideRepository() -> AnimeRepositoryProtocol {
    let realm = try? Realm()

    let locale: LocaleDataSource = LocaleDataSource.sharedInstance(realm)
    let remote: RemoteDataSource = RemoteDataSource.sharedInstance

    return AnimeRepository.sharedInstance(locale, remote)
  }

  func provideHome() -> HomeUseCase {
    let repository = provideRepository()
    return HomeInteractor(repository: repository)
  }

  func provideAnimeDetail(anime: AnimeModel) -> AnimeDetailUseCase {
    let repository = provideRepository()
    return AnimeDetailInteractor(repository: repository, anime: anime)
  }

}
