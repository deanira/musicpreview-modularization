//
//  HomeInjection.swift
//  Home
//
//  Created by Deanira Fadrinaldi on 17/11/26.
//

import RealmSwift
import Common
import Core

@MainActor
public final class HomeInjection {
  private let realm: Realm
  private let networkService: NetworkService

  public init(realm: Realm, networkService: NetworkService) {
    self.realm = realm
    self.networkService = networkService
  }

  func provideHomeRepository() -> HomeRepositoryProtocol {
    let locale = HomeLocaleDataSource.sharedInstance(realm)
    let remote = HomeRemoteDataSource.sharedInstance(networkService)
    return HomeRepository.sharedInstance(locale, remote)
  }

  public func provideHomeUseCase() -> HomeUseCaseProtocol {
    let repository = provideHomeRepository()
    return HomeUseCase(repository: repository)
  }
}
