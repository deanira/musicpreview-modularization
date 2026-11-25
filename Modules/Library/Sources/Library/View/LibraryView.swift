//
//  LibraryView.swift
//  MusicPreview
//
//  Created by Deanira Fadrinaldi on 07/11/26.
//

import SwiftUI
import DesignSystem
import Player
import Profile

public struct LibraryView: View {
  @EnvironmentObject var viewModel: LibraryViewModel
  @EnvironmentObject private var playerViewModel: PlayerViewModel

  public init() { }

  public var body: some View {
    Group {
      if viewModel.savedTracks.isEmpty {
        emptyState
      } else {
        trackList
      }
    }
    .navigationTitle("common_title_library".localized())
    .toolbar {
      ToolbarItem(placement: .topBarTrailing) {
        NavigationLink {
          ProfileView()
        } label: {
          Image(systemName: "person")
            .foregroundStyle(.blue)
        }
      }
    }
  }

  private var trackList: some View {
    List {
      ForEach(viewModel.savedTracks) { track in
        Button {
          playerViewModel.play(track)
          playerViewModel.showNowPlaying = true
        } label: {
          TrackView(
            title: track.title,
            artist: track.artist,
            imageUrl: track.artworkUrlSmall,
            nowPlaying: playerViewModel.track?.id == track.id
          )
        }
        .buttonStyle(.plain)
        .listRowSeparator(.hidden, edges: track.id == viewModel.savedTracks.first?.id ? .top : [])
        .listRowSeparator(.hidden, edges: track.id == viewModel.savedTracks.last?.id ? .bottom : [])
        .swipeActions(edge: .leading) {
          Button {
            viewModel.deleteTrack(id: track.id)
          } label: {
            Image(systemName: "trash")
          }
          .tint(.red)
        }
      }
    }
    .listStyle(.plain)
    .scrollIndicators(.automatic)
  }

  private var emptyState: some View {
    ContentUnavailableView(
      "library_title_empty".localized(),
      systemImage: "music.note.list",
      description: Text("library_desc_empty".localized())
    )
  }
}
