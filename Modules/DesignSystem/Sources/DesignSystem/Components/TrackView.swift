//
//  TrackView.swift
//  MusicPreview
//
//  Created by Deanira Fadrinaldi on 10/11/26.
//

import Kingfisher
import SwiftUI

public struct TrackView: View {
  let title: String
  let artist: String
  let imageUrl: String
  let nowPlaying: Bool?

  public init(title: String, artist: String, imageUrl: String, nowPlaying: Bool? = nil) {
    self.title = title
    self.artist = artist
    self.imageUrl = imageUrl
    self.nowPlaying = nowPlaying
  }

  public var body: some View {
    HStack {
      if let imageUrl = URL(string: imageUrl) {
        KFImage(imageUrl)
          .resizable()
          .frame(width: 60, height: 60)
          .clipShape(RoundedRectangle(cornerRadius: 8))
      }

      VStack(alignment: .leading) {
        Text(title)
          .bold()
        Text(artist)
      }

      Spacer()

      if nowPlaying ?? false {
        Image(systemName: "waveform.mid")
          .symbolEffect(.bounce.up.byLayer, options: .repeat(.continuous))
      }
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .contentShape(Rectangle())
  }
}
