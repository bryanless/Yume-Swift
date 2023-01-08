//
//  Formatter+Ext.swift
//  
//
//  Created by Bryan on 08/01/23.
//

import SwiftUI

public struct Formatter {
  // MARK: - Color
  public static func rgbToColor(red: Double, green: Double, blue: Double) -> Color {
    return Color(red: red / 255, green: green / 255, blue: blue / 255)
  }
}
