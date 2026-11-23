//
//  SearchRepository.swift
//  Search
//
//  Created by Deanira Fadrinaldi on 17/11/26.
//

import Combine
import Core

final class SearchRepository {
  fileprivate let locale: SearchLocaleDataSourceProtocol
  fileprivate let remote: SearchRemoteDataSourceProtocol

  init(locale: SearchLocaleDataSourceProtocol, remote: SearchRemoteDataSourceProtocol) {
    self.locale = locale
    self.remote = remote
  }

  @MainActor static let sharedInstance: (SearchLocaleDataSourceProtocol, SearchRemoteDataSourceProtocol) -> SearchRepository = { locale, remote in
    SearchRepository(locale: locale, remote: remote)
  }
}

extension SearchRepository: SearchRepositoryProtocol {
  func searchTracks(query: String) -> AnyPublisher<[TrackModel], any Error> {
    return self.remote.searchTracks(query: query)
      .map { TrackMapper.mapTrackResponsesToDomains(input: $0) }
      .eraseToAnyPublisher()
  }

  func addSavedTrack(_ track: TrackModel) -> AnyPublisher<Bool, any Error> {
    return self.locale.addSavedTrack(TrackMapper.mapTrackDomainToEntity(input: track))
  }
}
