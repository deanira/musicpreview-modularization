//
//  Injection.swift
//  MusicPreview
//
//  Created by Deanira Fadrinaldi on 01/11/26.
//

import RealmSwift
import Common
import Core
import Home
import Library
import Player
import Profile
import Search

@MainActor
final class Injection {
  private let network: NetworkService
  private let realm: Realm
  private let audioPlayer: AudioPlayerManagerProtocol

  private lazy var homeInjection = HomeInjection(realm: realm, networkService: network)
  private lazy var searchInjection = SearchInjection(realm: realm, networkService: network)
  private lazy var libraryInjection = LibraryInjection(realm: realm)
  private lazy var profileInjection = ProfileInjection()

  init(
    realm: Realm,
    network: NetworkService = NetworkService(),
    audioPlayer: AudioPlayerManagerProtocol? = nil
  ) {
    self.realm = realm
    self.network = network
    self.audioPlayer = audioPlayer ?? AudioPlayerManager.shared
  }

  func provideHomeViewModel() -> HomeViewModel {
    HomeViewModel(homeUseCase: homeInjection.provideHomeUseCase())
  }

  func provideSearchViewModel() -> SearchViewModel {
    SearchViewModel(searchUseCase: searchInjection.provideSearchUseCase())
  }

  func provideLibraryViewModel() -> LibraryViewModel {
    LibraryViewModel(libraryUseCase: libraryInjection.provideLibraryUseCase())
  }

  func provideProfileViewModel() -> ProfileViewModel {
    ProfileViewModel(profileUseCase: profileInjection.provideProfileUseCase())
  }

  func providePlayerViewModel() -> PlayerViewModel {
    PlayerViewModel(audioPlayerManager: audioPlayer)
  }
}
