//
//  FormatterExtension.swift
//  Yume
//
//  Created by Bryan on 28/12/22.
//

import Foundation
import SwiftUI

struct Formatter {
  static func toShortDate(_ dateString: String) -> String {
    let dateFormatterApi = DateFormatter()
    let dateFormatterResult = DateFormatter()

    dateFormatterApi.dateFormat = "yyyy-MM-dd"
    dateFormatterResult.dateFormat = "MMM dd, yyyy"

    guard let date = dateFormatterApi.date(from: dateString) else {
      return dateString
    }

    let released = dateFormatterResult.string(from: date)

    return released
  }

  static func toFullDate(_ dateString: String) -> String {
    let dateFormatterApi = DateFormatter()
    let dateFormatterResult = DateFormatter()

    dateFormatterApi.dateFormat = "yyyy-MM-dd"
    dateFormatterResult.dateFormat = "MMMM dd, yyyy"

    guard let date = dateFormatterApi.date(from: dateString) else {
      return dateString
    }

    let released = dateFormatterResult.string(from: date)

    return released
  }

  static func toApiDate(_ dateString: String) -> String {
    let dateFormatterNow = DateFormatter()
    let dateFormatterApi = DateFormatter()

    dateFormatterNow.dateFormat = "MMMM dd, yyyy"
    dateFormatterApi.dateFormat = "yyyy-MM-dd"

    guard let date = dateFormatterNow.date(from: dateString) else {
      return dateString
    }

    let released = dateFormatterApi.string(from: date)

    return released
  }

  static func rgbToColor(red: Double, green: Double, blue: Double) -> Color {
    return Color(red: red / 255, green: green / 255, blue: blue / 255)
  }

  // Formatting numbers https://stackoverflow.com/a/48371527
  static func formatNumber(_ number: Int) -> String {
    let num = abs(Double(number))
    let sign = (number < 0) ? "-" : ""

    switch num {
    case 1_000_000_000...:
      var formatted = num / 1_000_000_000
      formatted = formatted.reduceScale(to: 1)
      return "\(sign)\(formatted)B"

    case 1_000_000...:
      var formatted = num / 1_000_000
      formatted = formatted.reduceScale(to: 1)
      return "\(sign)\(formatted)M"

    case 1_000...:
      var formatted = num / 1_000
      formatted = formatted.reduceScale(to: 1)
      return "\(sign)\(formatted)K"

    case 0...:
      return "\(number)"

    default:
      return "\(sign)\(number)"
    }
  }
}

extension Double {
  func reduceScale(to places: Int) -> Double {
    let multiplier = pow(10, Double(places))
    let newDecimal = multiplier * self // move the decimal right
    let truncated = Double(Int(newDecimal)) // drop the fraction
    let originalDecimal = truncated / multiplier // move the decimal back
    return originalDecimal
  }
}
