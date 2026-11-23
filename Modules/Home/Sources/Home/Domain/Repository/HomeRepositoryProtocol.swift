//
//  HomeRepositoryProtocol.swift
//  Home
//
//  Created by Deanira Fadrinaldi on 17/11/26.
//

import Combine
import Core

protocol HomeRepositoryProtocol {
  func fetchMostPlayedSongs(request: MostPlayedRequest) -> AnyPublisher<[TrackModel], Error>
  func addSavedTrack(_ track: TrackModel) -> AnyPublisher<Bool, Error>
}
