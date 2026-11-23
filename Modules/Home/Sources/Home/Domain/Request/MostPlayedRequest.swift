//
//  MostPlayedRequest.swift
//  MusicPreview
//
//  Created by Deanira Fadrinaldi on 06/11/26.
//

public struct MostPlayedRequest: Codable, Sendable {
  let countryCode: String
  let limit: Int
}
