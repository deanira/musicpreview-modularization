//
//  AudioPlayerManager.swift
//  MusicPreview
//
//  Created by Deanira Fadrinaldi on 10/11/26.
//

@preconcurrency import AVFoundation
import Combine

@MainActor
public final class AudioPlayerManager: AudioPlayerManagerProtocol {
  public static let shared = AudioPlayerManager()

  private let player = AVPlayer()
  private var timeObserver: Any?
  private var endObserver: NSObjectProtocol?

  private let isPlayingSubject = CurrentValueSubject<Bool, Never>(false)
  private let currentTimeSubject = CurrentValueSubject<Double, Never>(0)
  private let durationSubject = CurrentValueSubject<Double, Never>(0)
  private let didFinishSubject = PassthroughSubject<Void, Never>()

  public var isPlayingPublisher: AnyPublisher<Bool, Never> { isPlayingSubject.eraseToAnyPublisher() }
  public var currentTimePublisher: AnyPublisher<Double, Never> { currentTimeSubject.eraseToAnyPublisher() }
  public var durationPublisher: AnyPublisher<Double, Never> { durationSubject.eraseToAnyPublisher() }
  public var didFinishPublisher: AnyPublisher<Void, Never> { didFinishSubject.eraseToAnyPublisher() }

  public init() {
    try? AVAudioSession.sharedInstance().setCategory(.playback)

    timeObserver = player.addPeriodicTimeObserver(
      forInterval: CMTime(seconds: 0.25, preferredTimescale: 600),
      queue: .main
    ) { [weak self] time in
      MainActor.assumeIsolated {
        self?.currentTimeSubject.send(time.seconds)
      }
    }
  }

  public func load(url: URL) {
    let item = AVPlayerItem(url: url)
    player.replaceCurrentItem(with: item)
    currentTimeSubject.send(0)
    durationSubject.send(0)
    observeEnd(of: item)

    Task { [weak self] in
      guard let seconds = try? await item.asset.load(.duration).seconds else { return }
      guard let self, self.player.currentItem === item else { return }   // ignore stale loads
      self.durationSubject.send(seconds)
    }

    play()
  }

  public func play() {
    player.play()
    isPlayingSubject.send(true)
  }

  public func pause() {
    player.pause()
    isPlayingSubject.send(false)
  }

  public func seek(to seconds: Double) {
    let time = CMTime(seconds: seconds, preferredTimescale: 600)
    player.seek(to: time, toleranceBefore: .zero, toleranceAfter: .zero)
  }

  private func observeEnd(of item: AVPlayerItem) {
    if let endObserver { NotificationCenter.default.removeObserver(endObserver) }
    endObserver = NotificationCenter.default.addObserver(
      forName: AVPlayerItem.didPlayToEndTimeNotification, object: item, queue: .main
    ) { [weak self] _ in
      MainActor.assumeIsolated {
        self?.player.seek(to: .zero)
        self?.currentTimeSubject.send(0)
        self?.isPlayingSubject.send(false)
        self?.didFinishSubject.send()
      }
    }
  }
}
