//
//  SearchRequest.swift
//  MusicPreview
//
//  Created by Deanira Fadrinaldi on 01/11/26.
//

public struct SearchRequest: Codable, Sendable {
  var id: String?
  var term: String?
  var media: String?
  var entity: String?
  var limit: Int?

  public init(
    id: String? = nil,
    term: String? = nil,
    media: String? = nil,
    entity: String? = nil,
    limit: Int? = nil
  ) {
    self.id = id
    self.term = term
    self.media = media
    self.entity = entity
    self.limit = limit
  }
}
