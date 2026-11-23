//
//  LibraryLocaleDataSource.swift
//  Library
//
//  Created by Deanira Fadrinaldi on 16/11/26.
//

import Combine
import RealmSwift
import Foundation
import Common
import Core

protocol LibraryLocaleDataSourceProtocol {
  func fetchSavedTracks() -> AnyPublisher<[TrackEntity], Error>
  func deleteSavedTrack(id: String) -> AnyPublisher<Bool, Error>
}

final class LibraryLocaleDataSource {
  private let realm: Realm?

  private init(realm: Realm?) {
    self.realm = realm
  }

  @MainActor static let sharedInstance: (Realm?) -> LibraryLocaleDataSource = { realmDatabase in
    return LibraryLocaleDataSource(realm: realmDatabase)
  }

  // MARK: - for unit test
  static func make(realm: Realm?) -> LibraryLocaleDataSource {
    return LibraryLocaleDataSource(realm: realm)
  }
}

extension LibraryLocaleDataSource: LibraryLocaleDataSourceProtocol {
  func fetchSavedTracks() -> AnyPublisher<[TrackEntity], Error> {
    guard let realm = self.realm else {
      return Fail(error: DatabaseError.invalidInstance).eraseToAnyPublisher()
    }

    return realm.objects(TrackEntity.self)
      .collectionPublisher
      .subscribe(on: DispatchQueue.main)
      .freeze()
      .map { $0.toArray(ofType: TrackEntity.self) }
      .mapError { $0 as Error }
      .eraseToAnyPublisher()
  }

  func deleteSavedTrack(id: String) -> AnyPublisher<Bool, Error> {
    Deferred {
      Future<Bool, Error> { completion in
        guard let realm = self.realm else {
          completion(.failure(DatabaseError.invalidInstance))
          return
        }
        guard let track = realm.object(ofType: TrackEntity.self, forPrimaryKey: id) else {
          completion(.success(false)) // missing track, nothing to delete
          return
        }
        do {
          try realm.write {
            realm.delete(track)
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
