//
//  HomeRepository.swift
//  Home
//
//  Created by Deanira Fadrinaldi on 17/11/26.
//

import Combine
import Core

final class HomeRepository {
  fileprivate let locale: HomeLocaleDataSourceProtocol
  fileprivate let remote: HomeRemoteDataSourceProtocol

  init(locale: HomeLocaleDataSourceProtocol, remote: HomeRemoteDataSourceProtocol) {
    self.locale = locale
    self.remote = remote
  }

  @MainActor static let sharedInstance: (HomeLocaleDataSourceProtocol, HomeRemoteDataSourceProtocol) -> HomeRepository = { locale, remote in
    HomeRepository(locale: locale, remote: remote)
  }
}

extension HomeRepository: HomeRepositoryProtocol {
  func fetchMostPlayedSongs(request: MostPlayedRequest) -> AnyPublisher<[TrackModel], any Error> {
    return self.remote.fetchMostPlayedSongs(request: request)
      .flatMap { result -> AnyPublisher<[TrackModel], Error> in
        let ids = result
          .compactMap { $0.id }
          .joined(separator: ",")

        let searchRequest = SearchRequest(id: ids, entity: "song")
        return self.remote.fetchTrackDetail(request: searchRequest)
          .map { TrackMapper.mapTrackResponsesToDomains(input: $0) }
          .eraseToAnyPublisher()
      }
      .eraseToAnyPublisher()
  }

  func addSavedTrack(_ track: TrackModel) -> AnyPublisher<Bool, any Error> {
    return self.locale.addSavedTrack(TrackMapper.mapTrackDomainToEntity(input: track))
  }
}
