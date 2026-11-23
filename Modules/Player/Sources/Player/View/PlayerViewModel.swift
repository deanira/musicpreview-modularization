//
//  PlayerViewModel.swift
//  MusicPreview
//
//  Created by Deanira Fadrinaldi on 07/11/26.
//

import Combine
import Foundation
import Core

@MainActor
public final class PlayerViewModel: ObservableObject {
  private let audioPlayerManager: AudioPlayerManagerProtocol

  private var cancellables: Set<AnyCancellable> = []

  // MARK: - UI state
  @Published public var track: TrackModel? = nil
  @Published private(set) var isLoading = false
  @Published private(set) var errorMessage = ""
  @Published private(set) var message = ""

  // MARK: - UI state player
  @Published public private(set) var isPlaying = false
  @Published private(set) var duration: Double = 0
  @Published private(set) var isScrubbing = false
  @Published var currentTime: Double = 0
  @Published public var showNowPlaying = false

  // MARK: - Presentation
  public var title: String { track?.title ?? "" }
  var artist: String { track?.artist ?? "" }
  public var hasTrack: Bool { track != nil }

  var artworkURL: URL? {
    guard let large = track?.artworkUrlLarge else { return nil }
    return URL(string: large.replacingOccurrences(of: "100x100", with: "600x600"))
  }

  public var smallArtworkURL: URL? {
    URL(string: track?.artworkUrlSmall ?? "")
  }

  var currentTimeText: String { Self.format(seconds: currentTime) }
  var durationText: String { Self.format(seconds: duration) }
  var sliderRange: ClosedRange<Double> { 0...max(duration, 1) }

  public init(audioPlayerManager: AudioPlayerManagerProtocol) {
    self.audioPlayerManager = audioPlayerManager
    bind()
  }

  // MARK: - Actions
  public func play(_ track: TrackModel) {
    guard let url = URL(string: track.previewUrl) else { return }
    self.track = track
    audioPlayerManager.load(url: url)
  }

  public func togglePlayPause() {
    isPlaying ? audioPlayerManager.pause() : audioPlayerManager.play()
  }

  func scrubbingChanged(_ editing: Bool) {
    isScrubbing = editing
    if !editing {
      audioPlayerManager.seek(to: currentTime)
    }
  }

  // MARK: - Private
  private func bind() {
    audioPlayerManager.isPlayingPublisher
      .receive(on: DispatchQueue.main)
      .sink { [weak self] in self?.isPlaying = $0 }
      .store(in: &cancellables)

    audioPlayerManager.durationPublisher
      .receive(on: DispatchQueue.main)
      .sink { [weak self] in self?.duration = $0 }
      .store(in: &cancellables)

    audioPlayerManager.currentTimePublisher
      .receive(on: DispatchQueue.main)
      .sink { [weak self] time in
        guard let self, !self.isScrubbing else { return }
        self.currentTime = time
      }
      .store(in: &cancellables)
  }

  private static func format(seconds: Double) -> String {
    guard seconds.isFinite, seconds >= 0 else { return "0:00" }
    let total = Int(seconds)
    return String(format: "%d:%02d", total / 60, total % 60)
  }
}
