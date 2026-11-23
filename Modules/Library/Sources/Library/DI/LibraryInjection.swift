//
//  LibraryInjection.swift
//  Library
//
//  Created by Deanira Fadrinaldi on 17/11/26.
//

import RealmSwift

@MainActor
public final class LibraryInjection {
  private let realm: Realm

  public init(realm: Realm) {
    self.realm = realm
  }

  func provideLibraryRepository() -> LibraryRepositoryProtocol {
    let locale = LibraryLocaleDataSource.sharedInstance(realm)
    return LibraryRepository.sharedInstance(locale)
  }

  public func provideLibraryUseCase() -> LibraryUseCaseProtocol {
    let repository = provideLibraryRepository()
    return LibraryUseCase(repository: repository)
  }
}
