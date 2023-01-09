//
//  GetAnimeLocaleDataSource.swift
//  
//
//  Created by Bryan on 07/01/23.
//

import Core
import Combine
import Foundation
import RealmSwift

public struct GetAnimeLocaleDataSource: LocaleDataSource {

  public typealias Request = Int
  public typealias Response = AnimeModuleEntity

  private let _realm: Realm

  public init(realm: Realm) {
    _realm = realm
  }

  public func list(request: Int?) -> AnyPublisher<[AnimeModuleEntity], Error> {
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
    return Future<AnimeModuleEntity, Error> { completion in
      if let animeEntity = _realm.object(ofType: AnimeModuleEntity.self, forPrimaryKey: id) {
        completion(.success(animeEntity))
      } else {
        completion(.failure(DatabaseError.requestFailed))
      }
    }.eraseToAnyPublisher()
  }

  public func update(id: Int, entity: AnimeModuleEntity) -> AnyPublisher<Bool, Error> {
    fatalError()
  }

}
