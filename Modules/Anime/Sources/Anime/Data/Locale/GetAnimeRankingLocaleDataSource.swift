//
//  GetAnimeRankingLocaleDataSource.swift
//  
//
//  Created by Bryan on 08/01/23.
//

import Core
import Combine
import Foundation
import RealmSwift

public struct GetAnimeRankingLocaleDataSource: LocaleDataSource {

  public typealias Request = AnimeRankingModuleRequest
  public typealias Response = AnimeModuleEntity

  private let _realm: Realm

  public init(realm: Realm) {
    _realm = realm
  }

  public func list(request: AnimeRankingModuleRequest?) -> AnyPublisher<[AnimeModuleEntity], Error> {
    return Future<[AnimeModuleEntity], Error> { completion in
      let animes: Results<AnimeModuleEntity> = {
        switch request?.rankingType {
        case "airing":
          return _realm.objects(AnimeModuleEntity.self)
            .where {
              $0.status == Status.currentlyAiring.name
              && $0.rank != 0
            }
            .sorted(byKeyPath: "rank")
        case "upcoming":
          return _realm.objects(AnimeModuleEntity.self)
            .where { $0.status == Status.notYetAired.name }
            .sorted(byKeyPath: "popularity")
        case "bypopularity":
          return _realm.objects(AnimeModuleEntity.self)
            .where { $0.popularity != 0 }
            .sorted(byKeyPath: "popularity")
        case "favorite":
          return _realm.objects(AnimeModuleEntity.self)
            .sorted(byKeyPath: "favoriteAmount", ascending: false)
        default:
          // All
          return _realm.objects(AnimeModuleEntity.self)
            .where { $0.rank != 0 }
            .sorted(byKeyPath: "rank")
        }
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

  public func get(id: Int) -> AnyPublisher<AnimeModuleEntity, Error> {
    fatalError()
  }

  public func update(id: Int, entity: AnimeModuleEntity) -> AnyPublisher<Bool, Error> {
    fatalError()
  }

}
