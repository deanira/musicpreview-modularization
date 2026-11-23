//
//  HomeView.swift
//  MusicPreview
//
//  Created by Deanira Fadrinaldi on 02/11/26.
//

import Kingfisher
import SwiftUI

import Player
import Profile

public struct HomeView: View {
  @EnvironmentObject var viewModel: HomeViewModel
  @EnvironmentObject var playerViewModel: PlayerViewModel

  public init() { }

  public var body: some View {
    ZStack {
      List {
        ForEach(viewModel.topTracks) { track in
          Button {
            playerViewModel.play(track)
            playerViewModel.showNowPlaying = true
          } label: {
            TrackView(track: track, nowPlaying: playerViewModel.track?.id == track.id)
          }
          .buttonStyle(.plain)
          .listRowSeparator(.hidden, edges: track.id == viewModel.topTracks.first?.id ? .top : [])
          .listRowSeparator(.hidden, edges: track.id == viewModel.topTracks.last?.id ? .bottom : [])
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
      .frame(maxHeight: .infinity)
      .scrollIndicators(.hidden)
      .listStyle(.plain)

      if viewModel.isLoadingTopTracks {
        ProgressView()
      } else if !viewModel.errorMessage.isEmpty {
        VStack {
          Text("Error: \(viewModel.errorMessage)")
            .multilineTextAlignment(.center)
          Button {
            viewModel.fetchTopTracks()
          } label: {
            Text("common_action_try_again".localized())
          }
        }
        .padding()
      }
    }
    .navigationTitle("common_title_home".localized())
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
    .onAppear {
      if viewModel.topTracks.count == 0 {
        viewModel.fetchTopTracks()
      }
    }
  }
}
