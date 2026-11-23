//
//  AudioPlayerManagerProtocol.swift
//  MusicPreview
//
//  Created by Deanira Fadrinaldi on 10/11/26.
//

import Combine
import Foundation

@MainActor
public protocol AudioPlayerManagerProtocol {
  var isPlayingPublisher: AnyPublisher<Bool, Never> { get }
  var currentTimePublisher: AnyPublisher<Double, Never> { get }
  var durationPublisher: AnyPublisher<Double, Never> { get }
  var didFinishPublisher: AnyPublisher<Void, Never> { get }

  func load(url: URL)
  func play()
  func pause()
  func seek(to seconds: Double)
}
