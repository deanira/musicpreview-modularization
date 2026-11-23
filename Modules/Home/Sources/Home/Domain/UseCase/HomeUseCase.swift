//
//  HomeUseCase.swift
//  MusicPreview
//
//  Created by Deanira Fadrinaldi on 02/11/26.
//

import Combine
import Core

public protocol HomeUseCaseProtocol {
  func fetchMostPlayedSongs(request: MostPlayedRequest) -> AnyPublisher<[TrackModel], Error>
  func addSavedTrack(_ track: TrackModel) -> AnyPublisher<Bool, Error>
}

final class HomeUseCase: HomeUseCaseProtocol {
  private let repository: HomeRepositoryProtocol

  init(repository: HomeRepositoryProtocol) {
    self.repository = repository
  }

  func fetchMostPlayedSongs(request: MostPlayedRequest) -> AnyPublisher<[TrackModel], Error> {
    repository.fetchMostPlayedSongs(request: request)
  }

  func addSavedTrack(_ track: TrackModel) -> AnyPublisher<Bool, Error> {
    repository.addSavedTrack(track)
  }
}
