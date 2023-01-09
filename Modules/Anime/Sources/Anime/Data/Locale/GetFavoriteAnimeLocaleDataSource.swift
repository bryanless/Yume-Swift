//
//  GetFavoriteAnimeLocaleDataSource.swift
//  
//
//  Created by Bryan on 07/01/23.
//

import Combine
import Core
import RealmSwift

public struct GetFavoriteAnimeLocaleDataSource: LocaleDataSource {

  public typealias Request = Int
  public typealias Response = AnimeModuleEntity

  private let _realm: Realm

  public init(realm: Realm) {
    _realm = realm
  }

  public func list(request: Int?) -> AnyPublisher<[AnimeModuleEntity], Error> {
    return Future<[AnimeModuleEntity], Error> { completion in
      let animes: Results<AnimeModuleEntity> = {
        _realm.objects(AnimeModuleEntity.self)
          .where { $0.isFavorite == true }
          .sorted(byKeyPath: "title")
      }()
      completion(.success(animes.toArray(ofType: AnimeModuleEntity.self)))
    }.eraseToAnyPublisher()
  }

  public func add(entities: [AnimeModuleEntity]) -> AnyPublisher<Bool, Error> {
    fatalError()
  }

  public func get(id: Int) -> AnyPublisher<AnimeModuleEntity, Error> {
    return Future<AnimeModuleEntity, Error> { completion in
      if let animeEntity = _realm.object(ofType: AnimeModuleEntity.self, forPrimaryKey: id) {
        do {
          try _realm.write {
            animeEntity.setValue(!animeEntity.isFavorite, forKey: "isFavorite")
          }
          completion(.success(animeEntity))
        } catch {
          completion(.failure(DatabaseError.requestFailed))
        }
      } else {
        completion(.failure(DatabaseError.requestFailed))
      }
    }.eraseToAnyPublisher()
  }

  public func update(id: Int, entity: AnimeModuleEntity) -> AnyPublisher<Bool, Error> {
    fatalError()
  }

}
