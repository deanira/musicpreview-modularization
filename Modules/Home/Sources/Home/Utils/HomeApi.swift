//
//  HomeApi.swift
//  Home
//
//  Created by Deanira Fadrinaldi on 17/11/26.
//

import Common
import Core

enum HomeApi {
  case lookupSong(request: SearchRequest)
  case mostPlayedSongs(request: MostPlayedRequest)
}

extension HomeApi: NetworkModelRequest {
  var baseURL: String {
    switch self {
    case .lookupSong:
      "https://itunes.apple.com"
    case .mostPlayedSongs:
      "https://rss.marketingtools.apple.com"
    }
  }

  var path: String {
    switch self {
    case .lookupSong:
      "/lookup"
    case .mostPlayedSongs(let request):
      "/api/v2/\(request.countryCode)/music/most-played/\(request.limit)/songs.json"
    }
  }

  var parameters: (any Codable & Sendable)? {
    switch self {
    case .lookupSong(let request):
      request
    case .mostPlayedSongs(let request):
      request
    }
  }
}
