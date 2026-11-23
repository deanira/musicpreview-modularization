//
//  SongResponse.swift
//  MusicPreview
//
//  Created by Deanira Fadrinaldi on 01/11/26.
//

public struct SearchResponse: Decodable, Sendable {
  public let results: [TrackResponse]?
}

public struct TrackResponse: Decodable, Sendable {
  let id: Int?
  let title: String?
  let artist: String?
  let artworkUrlLarge: String?
  let artworkUrlSmall: String?
  let previewUrl: String?
  let durationMillis: Int?

  private enum CodingKeys: String, CodingKey {
    case id = "trackId"
    case title = "trackName"
    case artist = "artistName"
    case artworkUrlLarge = "artworkUrl100"
    case artworkUrlSmall = "artworkUrl60"
    case previewUrl = "previewUrl"
    case durationMillis = "trackTimeMillis"
  }
}
