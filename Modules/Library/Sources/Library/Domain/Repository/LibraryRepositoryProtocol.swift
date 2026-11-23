//
//  LibraryRepositoryProtocol.swift
//  Library
//
//  Created by Deanira Fadrinaldi on 17/11/26.
//

import Combine
import Core

protocol LibraryRepositoryProtocol {
  func fetchSavedTracks() -> AnyPublisher<[TrackModel], Error>
  func deleteSavedTrack(id: String) -> AnyPublisher<Bool, Error>
}
