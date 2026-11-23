//
//  HomeLocaleDataSource.swift
//  Home
//
//  Created by Deanira Fadrinaldi on 16/11/26.
//

import Combine
import RealmSwift
import Foundation
import Common
import Core

protocol HomeLocaleDataSourceProtocol {
  func addSavedTrack(_ track: TrackEntity) -> AnyPublisher<Bool, Error>
}

final class HomeLocaleDataSource {
  private let realm: Realm?

  private init(realm: Realm?) {
    self.realm = realm
  }

  @MainActor static let sharedInstance: (Realm?) -> HomeLocaleDataSource = { realmDatabase in
    return HomeLocaleDataSource(realm: realmDatabase)
  }

  // MARK: - for unit test
  static func make(realm: Realm?) -> HomeLocaleDataSource {
    return HomeLocaleDataSource(realm: realm)
  }
}

// MARK: - Tracks
extension HomeLocaleDataSource: HomeLocaleDataSourceProtocol {
  func addSavedTrack(_ track: TrackEntity) -> AnyPublisher<Bool, Error> {
    Deferred {
      Future<Bool, Error> { completion in
        guard let realm = self.realm else {
          completion(.failure(DatabaseError.invalidInstance))
          return
        }
        do {
          try realm.write {
            realm.add(track, update: .modified)
          }
          completion(.success(true))
        } catch {
          completion(.failure(error))
        }
      }
    }
    .eraseToAnyPublisher()
  }
}
