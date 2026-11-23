//
//  SearchRemoteDataSource.swift
//  Search
//
//  Created by Deanira Fadrinaldi on 17/11/26.
//

import Alamofire
import Combine
import Foundation
import Common
import Core

protocol SearchRemoteDataSourceProtocol {
  func searchTracks(query: String) -> AnyPublisher<[TrackResponse], Error>
}

final class SearchRemoteDataSource: NSObject {
  private let network: NetworkService
  init(network: NetworkService) { self.network = network }

  @MainActor static let sharedInstance: (NetworkService) -> SearchRemoteDataSource = { network in
    SearchRemoteDataSource(network: network)
  }
}

extension SearchRemoteDataSource: SearchRemoteDataSourceProtocol {
  func searchTracks(query: String) -> AnyPublisher<[TrackResponse], Error> {
    let request = SearchRequest(term: query, media: "music", entity: "song", limit: 25)

    return network.perform(SearchApi.searchTracks(request: request), as: SearchResponse.self)
      .map { $0.results ?? [] }
      .eraseToAnyPublisher()
  }
}
