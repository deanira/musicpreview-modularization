//
//  SearchRepositoryProtocol.swift
//  Search
//
//  Created by Deanira Fadrinaldi on 17/11/26.
//

import Combine
import Core

public protocol SearchRepositoryProtocol {
  func searchTracks(query: String) -> AnyPublisher<[TrackModel], Error>
  func addSavedTrack(_ track: TrackModel) -> AnyPublisher<Bool, Error>
}
