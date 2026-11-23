//
//  MiniPlayerView.swift
//  MusicPreview
//
//  Created by Deanira Fadrinaldi on 10/11/26.
//

import Kingfisher
import SwiftUI
import Player

public struct MiniPlayerView: View {
  @EnvironmentObject private var viewModel: PlayerViewModel

  public init() { }

  public var body: some View {
    HStack(spacing: 12) {
      KFImage(viewModel.smallArtworkURL)
        .resizable()
        .frame(width: 36, height: 36)
        .clipShape(RoundedRectangle(cornerRadius: 6))

      Text(viewModel.title).lineLimit(1)

      Spacer()

      Button {
        viewModel.togglePlayPause()
      } label: {
        Image(systemName: viewModel.isPlaying ? "pause.fill" : "play.fill")
      }
      .buttonStyle(.plain)
    }
    .padding(.horizontal)
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .contentShape(Rectangle())
  }
}
