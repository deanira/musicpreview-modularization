//
//  HomeRemoteDataSource.swift
//  Home
//
//  Created by Deanira Fadrinaldi on 16/11/26.
//

import Alamofire
import Combine
import Foundation
import Common
import Core

protocol HomeRemoteDataSourceProtocol {
  func fetchMostPlayedSongs(request: MostPlayedRequest) -> AnyPublisher<[MostPlayedSong], Error>
  func fetchTrackDetail(request: SearchRequest) -> AnyPublisher<[TrackResponse], Error>
}

final class HomeRemoteDataSource: NSObject {
  private let network: NetworkService
  init(network: NetworkService) { self.network = network }

  @MainActor static let sharedInstance: (NetworkService) -> HomeRemoteDataSource = { network in
    HomeRemoteDataSource(network: network)
  }
}

extension HomeRemoteDataSource: HomeRemoteDataSourceProtocol {
  func fetchMostPlayedSongs(request: MostPlayedRequest) -> AnyPublisher<[MostPlayedSong], Error> {
    network.perform(HomeApi.mostPlayedSongs(request: request), as: MostPlayedResponse.self)
      .map { $0.feed?.results ?? [] }
      .eraseToAnyPublisher()
  }

  func fetchTrackDetail(request: SearchRequest) -> AnyPublisher<[TrackResponse], Error> {
    network.perform(HomeApi.lookupSong(request: request), as: SearchResponse.self)
      .map { $0.results ?? [] }
      .eraseToAnyPublisher()
  }
}
