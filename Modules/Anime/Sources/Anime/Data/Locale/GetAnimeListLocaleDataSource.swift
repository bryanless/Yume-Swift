//
//  GetAnimeListLocaleDataSource.swift
//  
//
//  Created by Bryan on 02/02/23.
//

import Core
import Combine
import Foundation
import RealmSwift

public struct GetAnimeListLocaleDataSource: LocaleDataSource {

  public typealias Request = AnimeListRequest
  public typealias Response = AnimeModuleEntity

  private let _realm: Realm

  public init(realm: Realm) {
    _realm = realm
  }

  public func list(request: AnimeListRequest?) -> AnyPublisher<[AnimeModuleEntity], Error> {
    fatalError()
  }

  public func add(entities: [AnimeModuleEntity]) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      do {
        try _realm.write {
          for anime in entities {
            if let animeEntity = _realm.object(ofType: AnimeModuleEntity.self, forPrimaryKey: anime.id) {
              anime.isFavorite = animeEntity.isFavorite
              _realm.add(anime, update: .all)
            } else {
              _realm.add(anime)
            }
          }
          completion(.success(true))
        }
      } catch {
        completion(.failure(DatabaseError.requestFailed))
      }
    }.eraseToAnyPublisher()
  }

  public func get(id: Int) -> AnyPublisher<AnimeModuleEntity, Error> {
    fatalError()
  }

  public func update(id: Int, entity: AnimeModuleEntity) -> AnyPublisher<Bool, Error> {
    fatalError()
  }

}
