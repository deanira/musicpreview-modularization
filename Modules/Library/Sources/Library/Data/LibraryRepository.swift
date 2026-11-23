//
//  LibraryRepository.swift
//  Library
//
//  Created by Deanira Fadrinaldi on 17/11/26.
//

import Combine
import Core

final class LibraryRepository {
  fileprivate let locale: LibraryLocaleDataSourceProtocol

  init(locale: LibraryLocaleDataSourceProtocol) {
    self.locale = locale
  }

  @MainActor static let sharedInstance: (LibraryLocaleDataSourceProtocol) -> LibraryRepository = { locale in
    LibraryRepository(locale: locale)
  }
}

extension LibraryRepository: LibraryRepositoryProtocol {
  func fetchSavedTracks() -> AnyPublisher<[TrackModel], any Error> {
    return self.locale.fetchSavedTracks()
      .map { TrackMapper.mapTrackEntitiesToDomains(input: $0) }
      .eraseToAnyPublisher()
  }

  func deleteSavedTrack(id: String) -> AnyPublisher<Bool, any Error> {
    return self.locale.deleteSavedTrack(id: id)
  }
}
