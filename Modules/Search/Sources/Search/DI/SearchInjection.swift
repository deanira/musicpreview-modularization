//
//  SearchInjection.swift
//  Search
//
//  Created by Deanira Fadrinaldi on 17/11/26.
//

import RealmSwift
import Common
import Core

@MainActor
public final class SearchInjection {
  private let realm: Realm
  private let networkService: NetworkService

  public init(realm: Realm, networkService: NetworkService) {
    self.realm = realm
    self.networkService = networkService
  }

  func provideSearchRepository() -> SearchRepositoryProtocol {
    let locale = SearchLocaleDataSource.sharedInstance(realm)
    let remote = SearchRemoteDataSource.sharedInstance(networkService)
    return SearchRepository.sharedInstance(locale, remote)
  }

  public func provideSearchUseCase() -> SearchUseCaseProtocol {
    let repository = provideSearchRepository()
    return SearchUseCase(repository: repository)
  }
}
