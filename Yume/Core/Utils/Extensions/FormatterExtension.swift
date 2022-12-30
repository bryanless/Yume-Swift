//
//  FormatterExtension.swift
//  Yume
//
//  Created by Bryan on 28/12/22.
//

import SwiftUI

struct Formatter {
  // MARK: - Date
  static func toShortDate(_ dateString: String) -> String {
    let dateFormatterApi = DateFormatter()
    let dateFormatterResult = DateFormatter()

    dateFormatterApi.dateFormat = "yyyy-MM-dd"
    dateFormatterResult.dateFormat = "MMM dd, yyyy"

    guard let date = dateFormatterApi.date(from: dateString) else {
      return self.toFullYearMonthDate(dateString)
    }

    let result = dateFormatterResult.string(from: date)

    return result
  }

  static func toFullDate(_ dateString: String) -> String {
    let dateFormatterApi = DateFormatter()
    let dateFormatterResult = DateFormatter()

    dateFormatterApi.dateFormat = "yyyy-MM-dd"
    dateFormatterResult.dateFormat = "MMMM dd, yyyy"

    guard let date = dateFormatterApi.date(from: dateString) else {
      return self.toFullYearMonthDate(dateString)
    }

    let result = dateFormatterResult.string(from: date)

    return result
  }

  static func toFullYearMonthDate(_ dateString: String) -> String {
    let dateFormatterApi = DateFormatter()
    let dateFormatterResult = DateFormatter()

    dateFormatterApi.dateFormat = "yyyy-MM"
    dateFormatterResult.dateFormat = "MMMM yyyy"

    guard let date = dateFormatterApi.date(from: dateString) else {
      return dateString
    }

    let result = dateFormatterResult.string(from: date)

    return result

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

  // MARK: - Color
  static func rgbToColor(red: Double, green: Double, blue: Double) -> Color {
    return Color(red: red / 255, green: green / 255, blue: blue / 255)
  }

  // MARK: - String
  static func snakeCaseToTitleCase(_ text: String) -> String {
    return text.replacingOccurrences(of: "_", with: " ").capitalized
  }

  // MARK: - Number
  static func secondsToHoursMinutes(_ seconds: Int) -> String {
    let (hour, min, _) = (seconds / 3600, (seconds % 3600) / 60, (seconds % 60))

    var text = ""

    if hour > 0 {
      text += "\(hour) hours "
    }

    if min > 0 {
      text += "\(min) minutes "
    }

    return text
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
