//
//  SongModel.swift
//  MusicPreview
//
//  Created by Deanira Fadrinaldi on 01/11/26.
//

public struct TrackModel: Equatable, Identifiable, Sendable {
  public let id: Int
  public let title: String
  public let artist: String
  public let artworkUrlLarge: String
  public let artworkUrlSmall: String
  public let previewUrl: String
  public let durationMillis: Int

  public init(
    id: Int,
    title: String,
    artist: String,
    artworkUrlLarge: String,
    artworkUrlSmall: String,
    previewUrl: String,
    durationMillis: Int
  ) {
    self.id = id
    self.title = title
    self.artist = artist
    self.artworkUrlLarge = artworkUrlLarge
    self.artworkUrlSmall = artworkUrlSmall
    self.previewUrl = previewUrl
    self.durationMillis = durationMillis
  }
}
