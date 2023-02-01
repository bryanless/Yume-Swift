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

  public typealias Request = AnimeRankingRequest
  public typealias Response = AnimeModuleEntity

  private let _realm: Realm

  public init(realm: Realm) {
    _realm = realm
  }

  public func list(request: AnimeRankingRequest?) -> AnyPublisher<[AnimeModuleEntity], Error> {
    return Future<[AnimeModuleEntity], Error> { completion in
      guard let request = request else {
        return completion(.failure(URLError.invalidRequest))
      }

      let animes: Results<AnimeModuleEntity> = {
        switch request.rankingType {
        case RankingTypeRequest.airing:
          return _realm.objects(AnimeModuleEntity.self)
            .where {
              $0.status == Status.currentlyAiring.name
              && $0.rank != 0
            }
            .sorted(byKeyPath: request.rankingType.sortKey)
        case .upcoming:
          return _realm.objects(AnimeModuleEntity.self)
            .where { $0.status == Status.notYetAired.name }
            .sorted(byKeyPath: request.rankingType.sortKey)
        case .byPopularity:
          return _realm.objects(AnimeModuleEntity.self)
            .where { $0.popularity != 0 }
            .sorted(byKeyPath: request.rankingType.sortKey)
        case .favorite:
          return _realm.objects(AnimeModuleEntity.self)
            .sorted(byKeyPath: request.rankingType.sortKey, ascending: false)
        default:
          // All
          return _realm.objects(AnimeModuleEntity.self)
            .where { $0.rank != 0 }
            .sorted(byKeyPath: request.rankingType.sortKey)
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
