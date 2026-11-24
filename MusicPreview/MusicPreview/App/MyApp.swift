import RealmSwift
import SwiftUI

import Common
import Home
import Library
import Player
import Profile
import Search

@main struct MyApp: App {
  @StateObject private var homeViewModel: HomeViewModel
  @StateObject private var libraryViewModel: LibraryViewModel
  @StateObject private var playerViewModel: PlayerViewModel
  @StateObject private var profileViewModel: ProfileViewModel
  @StateObject private var searchViewModel: SearchViewModel

  init() {
    let injection: Injection
    do {
      injection = Injection(realm: try Realm())
    } catch {
      fatalError("Failed opening realm: \(error)")
    }

    _homeViewModel = StateObject(wrappedValue: injection.provideHomeViewModel())
    _libraryViewModel = StateObject(wrappedValue: injection.provideLibraryViewModel())
    _playerViewModel = StateObject(wrappedValue: injection.providePlayerViewModel())
    _profileViewModel = StateObject(wrappedValue: injection.provideProfileViewModel())
    _searchViewModel = StateObject(wrappedValue: injection.provideSearchViewModel())
  }

  var body: some Scene {
    WindowGroup {
      ContentView()
        .environmentObject(homeViewModel)
        .environmentObject(libraryViewModel)
        .environmentObject(playerViewModel)
        .environmentObject(profileViewModel)
        .environmentObject(searchViewModel)
    }
  }
}
