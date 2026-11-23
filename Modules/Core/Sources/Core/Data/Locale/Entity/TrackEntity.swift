//
//  TrackEntity.swift
//  MusicPreview
//
//  Created by Deanira Fadrinaldi on 06/11/26.
//

import Foundation
import RealmSwift

public class TrackEntity: Object {
  @objc dynamic var id: String = ""
  @objc dynamic var title: String = ""
  @objc dynamic var artist: String = ""
  @objc dynamic var artworkUrlLarge: String = ""
  @objc dynamic var artworkUrlSmall: String = ""
  @objc dynamic var previewUrl: String = ""
  @objc dynamic var durationMillis: Int = 0

  override public class func primaryKey() -> String? {
    return "id"
  }
}
