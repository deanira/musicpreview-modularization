//
//  String+Ext.swift
//  Home
//
//  Created by Deanira Fadrinaldi on 22/11/26.
//

import Foundation
import Common

extension String {
  func localized() -> String {
    let localized = self.commonLocalized(Bundle.module)
    let commonLocalized = self.commonLocalized(CommonBundle.bundle)
    return localized == self ? commonLocalized : localized
  }
}
