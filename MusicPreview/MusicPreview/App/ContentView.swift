import Kingfisher
import SwiftUI
import Playgrounds

import Home
import Library
import Player
import Search

struct ContentView: View {
  @EnvironmentObject var playerViewModel: PlayerViewModel
  @Namespace private var namespace

  var body: some View {
    TabView {
      Tab {
        NavigationStack { HomeView() }
      } label: {
        Image(systemName: "house")
        Text("common_title_home".localized())
      }

      Tab {
        NavigationStack { SearchView() }
      } label: {
        Image(systemName: "magnifyingglass")
        Text("common_title_search".localized())
      }

      Tab {
        NavigationStack { LibraryView() }
      } label: {
        Image(systemName: "bookmark")
        Text("common_title_library".localized())
      }
    }
    .tabViewBottomAccessory(isEnabled: playerViewModel.hasTrack) {
      MiniPlayerView()
        .matchedTransitionSource(id: "player", in: namespace)
        .onTapGesture { playerViewModel.showNowPlaying = true }
    }
    .tabBarMinimizeBehavior(.onScrollDown)
    .sheet(isPresented: $playerViewModel.showNowPlaying) {
      PlayerView()
        .navigationTransition(.zoom(sourceID: "player", in: namespace))
    }
    .environmentObject(playerViewModel)
  }
}

#Preview {
  ContentView()
}

#Playground {
  _ = 1 + 2
}
