//
//  String+Ext.swift
//  MusicPreview
//
//  Created by Deanira Fadrinaldi on 23/11/26.
//

import Foundation
import Common

extension String {
  func localized() -> String {
    let localized = self.commonLocalized(Bundle.main)
    let commonLocalized = self.commonLocalized(CommonBundle.bundle)
    return localized == self ? commonLocalized : localized
  }
}
