//
//  ProfileRepositoryProtocol.swift
//  Profile
//
//  Created by Deanira Fadrinaldi on 17/11/26.
//

import Combine

protocol ProfileRepositoryProtocol {
  func fetchProfile() -> AnyPublisher<ProfileModel?, Error>
  func saveProfile(_ profile: ProfileModel) -> AnyPublisher<Bool, Error>
}
