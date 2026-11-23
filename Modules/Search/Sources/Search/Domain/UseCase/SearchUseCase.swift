//
//  HomeUseCase.swift
//  MusicPreview
//
//  Created by Deanira Fadrinaldi on 02/11/26.
//

import Combine
import Core

public protocol SearchUseCaseProtocol {
  func searchTracks(query: String) -> AnyPublisher<[TrackModel], Error>
  func addSavedTrack(_ track: TrackModel) -> AnyPublisher<Bool, Error>
}

final class SearchUseCase: SearchUseCaseProtocol {
  private let repository: SearchRepositoryProtocol

  init(repository: SearchRepositoryProtocol) {
    self.repository = repository
  }

  func searchTracks(query: String) -> AnyPublisher<[TrackModel], Error> {
    repository.searchTracks(query: query)
  }

  func addSavedTrack(_ track: TrackModel) -> AnyPublisher<Bool, Error> {
    repository.addSavedTrack(track)
  }
}
