//
//  LocaleDataSource.swift
//  Yume
//
//  Created by Bryan on 28/12/22.
//

import Foundation
import RealmSwift
import Combine

protocol LocaleDataSourceProtocol: AnyObject {

  func getTopAllAnimes() -> AnyPublisher<[AnimeEntity], Error>
  func addTopAllAnimes(from animes: [AnimeEntity]) -> AnyPublisher<Bool, Error>

}

final class LocaleDataSource: NSObject {

  private let realm: Realm?

  private init(realm: Realm?) {
    self.realm = realm
  }

  static let sharedInstance: (Realm?) -> LocaleDataSource = { realmDatabase in
    return LocaleDataSource(realm: realmDatabase)
  }

}

extension LocaleDataSource: LocaleDataSourceProtocol {

  // MARK: - Get top anime series
  func getTopAllAnimes() -> AnyPublisher<[AnimeEntity], Error> {
    return Future<[AnimeEntity], Error> { completion in
      if let realm = self.realm {
        let animes: Results<AnimeEntity> = {
          realm.objects(AnimeEntity.self)
        }()
        completion(.success(animes.toArray(ofType: AnimeEntity.self)))
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }

  func addTopAllAnimes(from animes: [AnimeEntity]) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      if let realm = self.realm {
        do {
          try realm.write {
            for anime in animes {
              realm.add(anime, update: .all)
            }
            completion(.success(true))
          }
        } catch {
          completion(.failure(DatabaseError.requestFailed))
        }
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }

  // MARK: - Get popular anime
  func getPopularAnimes() -> AnyPublisher<[PopularAnimeEntity], Error> {
    return Future<[PopularAnimeEntity], Error> { completion in
      if let realm = self.realm {
        let animes: Results<PopularAnimeEntity> = {
          realm.objects(PopularAnimeEntity.self)
        }()
        completion(.success(animes.toArray(ofType: PopularAnimeEntity.self)))
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }

  func addPopularAnimes(from animes: [PopularAnimeEntity]) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      if let realm = self.realm {
        do {
          try realm.write {
            for anime in animes {
              realm.add(anime, update: .all)
            }
            completion(.success(true))
          }
        } catch {
          completion(.failure(DatabaseError.requestFailed))
        }
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }

}

extension Results {

  func toArray<T>(ofType: T.Type) -> [T] {
    var array = [T]()
    for index in 0 ..< count {
      if let result = self[index] as? T {
        array.append(result)
      }
    }
    return array
  }

}
