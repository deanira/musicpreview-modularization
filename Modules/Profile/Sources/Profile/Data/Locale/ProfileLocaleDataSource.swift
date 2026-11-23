//
//  ProfileLocaleDataSourceProtocol.swift
//  Profile
//
//  Created by Deanira Fadrinaldi on 17/11/26.
//

import Combine
import Foundation

protocol ProfileLocaleDataSourceProtocol {
  func fetchProfile() -> AnyPublisher<ProfileEntity?, Error>
  func saveProfile(_ profile: ProfileEntity) -> AnyPublisher<Bool, Error>
}

final class ProfileLocaleDataSource {
  private let userDefaults: UserDefaults
  private let profileKey = "user.profile.v1"

  private init(userDefaults: UserDefaults = .standard) {
    self.userDefaults = userDefaults
  }

  @MainActor static let sharedInstance: ProfileLocaleDataSource = {
    return ProfileLocaleDataSource()
  }()

  // MARK: - for unit test
  static func make(userDefaults: UserDefaults) -> ProfileLocaleDataSource {
    return ProfileLocaleDataSource(userDefaults: userDefaults)
  }
}

extension ProfileLocaleDataSource: ProfileLocaleDataSourceProtocol {
  func fetchProfile() -> AnyPublisher<ProfileEntity?, Error> {
    Deferred {
      Future<ProfileEntity?, Error> { completion in
        guard let data = self.userDefaults.data(forKey: self.profileKey) else {
          completion(.success(nil))
          return
        }
        do {
          let profile = try JSONDecoder().decode(ProfileEntity.self, from: data)
          completion(.success(profile))
        } catch {
          completion(.failure(error))
        }
      }
    }
    .eraseToAnyPublisher()
  }

  func saveProfile(_ profile: ProfileEntity) -> AnyPublisher<Bool, Error> {
    Deferred {
      Future<Bool, Error> { completion in
        do {
          let data = try JSONEncoder().encode(profile)
          self.userDefaults.set(data, forKey: self.profileKey)
          completion(.success(true))
        } catch {
          completion(.failure(error))
        }
      }
    }
    .eraseToAnyPublisher()
  }
}
