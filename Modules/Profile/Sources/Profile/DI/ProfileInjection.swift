//
//  ProfileInjection.swift
//  Profile
//
//  Created by Deanira Fadrinaldi on 17/11/26.
//

@MainActor
public final class ProfileInjection {
  public init() { }

  func provideProfileRepository() -> ProfileRepositoryProtocol {
    let locale = ProfileLocaleDataSource.sharedInstance
    return ProfileRepository.sharedInstance(locale)
  }

  public func provideProfileUseCase() -> ProfileUseCaseProtocol {
    let repository = provideProfileRepository()
    return ProfileUseCase(repository: repository)
  }
}
