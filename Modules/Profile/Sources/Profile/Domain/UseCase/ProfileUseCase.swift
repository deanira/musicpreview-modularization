//
//  ProfileUseCase.swift
//  MusicPreview
//
//  Created by Deanira Fadrinaldi on 07/11/26.
//

import Combine

public protocol ProfileUseCaseProtocol {
  func fetchProfile() -> AnyPublisher<ProfileModel?, Error>
  func saveProfile(_ profile: ProfileModel) -> AnyPublisher<Bool, Error>
}

final class ProfileUseCase: ProfileUseCaseProtocol {
  private let repository: ProfileRepositoryProtocol

  init(repository: ProfileRepositoryProtocol) {
    self.repository = repository
  }

  func fetchProfile() -> AnyPublisher<ProfileModel?, any Error> {
    repository.fetchProfile()
  }

  func saveProfile(_ profile: ProfileModel) -> AnyPublisher<Bool, any Error> {
    repository.saveProfile(profile)
  }
}
