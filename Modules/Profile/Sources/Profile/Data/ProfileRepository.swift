//
//  ProfileRepository.swift
//  Profile
//
//  Created by Deanira Fadrinaldi on 17/11/26.
//

import Combine

final class ProfileRepository {
  fileprivate let locale: ProfileLocaleDataSourceProtocol

  init(locale: ProfileLocaleDataSourceProtocol) {
    self.locale = locale
  }

  @MainActor static let sharedInstance: (ProfileLocaleDataSourceProtocol) -> ProfileRepository = { locale in
    ProfileRepository(locale: locale)
  }
}

extension ProfileRepository: ProfileRepositoryProtocol {
  func fetchProfile() -> AnyPublisher<ProfileModel?, Error> {
    return self.locale.fetchProfile()
      .map { entity in
        entity.map { ProfileMapper.mapProfileEntitiesToDomains(input: $0) }
      }
      .eraseToAnyPublisher()
  }

  func saveProfile(_ profile: ProfileModel) -> AnyPublisher<Bool, Error> {
    return self.locale.saveProfile(ProfileMapper.mapProfileDomainToEntity(input: profile))
  }
}
