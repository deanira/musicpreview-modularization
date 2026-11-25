//
//  SearchView.swift
//  MusicPreview
//
//  Created by Deanira Fadrinaldi on 07/11/26.
//

import SwiftUI
import DesignSystem
import Player
import Profile

public struct SearchView: View {
  @EnvironmentObject var viewModel: SearchViewModel
  @EnvironmentObject private var playerViewModel: PlayerViewModel

  public init() { }

  public var body: some View {
    ZStack {
      List {
        ForEach(viewModel.resultTracks) { track in
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
          .listRowSeparator(.hidden, edges: track.id == viewModel.resultTracks.first?.id ? .top : [])
          .listRowSeparator(.hidden, edges: track.id == viewModel.resultTracks.last?.id ? .bottom : [])
          .swipeActions(edge: .trailing) {
            Button {
              viewModel.addSavedTrack(track)
            } label: {
              Image(systemName: "bookmark")
            }
            .tint(.green)
          }
        }
      }
      .listStyle(.plain)

      if viewModel.resultTracks.isEmpty {
        if viewModel.isLoading {
          ProgressView()
        } else if !viewModel.errorMessage.isEmpty {
          VStack {
            Text("Error: \(viewModel.errorMessage)")
              .multilineTextAlignment(.center)
            Button {
              viewModel.searchTracks()
            } label: {
              Text("common_action_try_again".localized())
            }
          }
          .padding()
        } else {
          Text("search_title_find_songs".localized())
            .frame(maxWidth: .infinity)
        }
      }
    }
    .frame(maxWidth: .infinity)
    .navigationTitle("common_title_search".localized())
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
    .searchable(
      text: $viewModel.query,
      placement: .navigationBarDrawer(displayMode: .always),
      prompt: "search_label_prompt".localized()
    )
  }
}
