//
//  GetTopAiringAnimesLocaleDataSource.swift
//  
//
//  Created by Bryan on 06/01/23.
//

import Core
import Combine
import Foundation
import RealmSwift

public struct GetTopAiringAnimesLocaleDataSource: LocaleDataSource {

  public typealias Request = Any
  public typealias Response = AnimeModuleEntity

  private let _realm: Realm

  public init(realm: Realm) {
    _realm = realm
  }

  public func list(request: Any?) -> AnyPublisher<[AnimeModuleEntity], Error> {
    return Future<[AnimeModuleEntity], Error> { completion in
      let animes: Results<AnimeModuleEntity> = {
        _realm.objects(AnimeModuleEntity.self)
          .where {
            $0.status == Status.currentlyAiring.name
            && $0.rank != 0
          }
          .sorted(byKeyPath: "rank")
      }()
      completion(.success(animes.toArray(ofType: AnimeModuleEntity.self)))
    }.eraseToAnyPublisher()
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

  public func get(id: String) -> AnyPublisher<AnimeModuleEntity, Error> {
    fatalError()
  }

  public func update(id: Int, entity: AnimeModuleEntity) -> AnyPublisher<Bool, Error> {
    fatalError()
  }

}
