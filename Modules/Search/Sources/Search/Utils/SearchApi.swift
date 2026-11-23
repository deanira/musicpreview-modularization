//
//  SearchApi.swift
//  Search
//
//  Created by Deanira Fadrinaldi on 18/11/26.
//

import Common
import Core

enum SearchApi {
  case searchTracks(request: SearchRequest)
}

extension SearchApi: NetworkModelRequest {
  var baseURL: String {
    "https://itunes.apple.com"
  }
  
  var path: String {
    "/search"
  }
  
  var parameters: (any Codable & Sendable)? {
    switch self {
    case .searchTracks(let request):
      request
    }
  }
}
