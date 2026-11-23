//
//  SearchLocaleDataSource.swift
//  Search
//
//  Created by Deanira Fadrinaldi on 17/11/26.
//

import Combine
import RealmSwift
import Foundation
import Common
import Core

protocol SearchLocaleDataSourceProtocol {
  func addSavedTrack(_ track: TrackEntity) -> AnyPublisher<Bool, Error>
}

final class SearchLocaleDataSource {
  private let realm: Realm?

  private init(realm: Realm?) {
    self.realm = realm
  }

  @MainActor static let sharedInstance: (Realm?) -> SearchLocaleDataSource = { realmDatabase in
    return SearchLocaleDataSource(realm: realmDatabase)
  }

  // MARK: - for unit test
  static func make(realm: Realm?) -> SearchLocaleDataSource {
    return SearchLocaleDataSource(realm: realm)
  }
}

// MARK: - Tracks
extension SearchLocaleDataSource: SearchLocaleDataSourceProtocol {
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
