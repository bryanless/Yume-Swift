//
//  String+Ext.swift
//  
//
//  Created by Bryan on 07/01/23.
//

import Foundation

extension String {
  public func apiToShortDate() -> String {
    let dateFormatterApi = DateFormatter()
    let dateFormatterResult = DateFormatter()

    dateFormatterApi.dateFormat = "yyyy-MM-dd"
    dateFormatterResult.dateFormat = "MMM dd, yyyy"

    guard let date = dateFormatterApi.date(from: self) else {
      return self.apiToFullYearMonthDate()
    }

    let result = dateFormatterResult.string(from: date)

    return result
  }

  public func apiToFullDate() -> String {
    let dateFormatterApi = DateFormatter()
    let dateFormatterResult = DateFormatter()

    dateFormatterApi.dateFormat = "yyyy-MM-dd"
    dateFormatterResult.dateFormat = "MMMM dd, yyyy"

    guard let date = dateFormatterApi.date(from: self) else {
      return self.apiToFullYearMonthDate()
    }

    let result = dateFormatterResult.string(from: date)

    return result
  }

  public func apiToFullYearMonthDate() -> String {
    let dateFormatterApi = DateFormatter()
    let dateFormatterResult = DateFormatter()

    dateFormatterApi.dateFormat = "yyyy-MM"
    dateFormatterResult.dateFormat = "MMMM yyyy"

    guard let date = dateFormatterApi.date(from: self) else {
      return self
    }

    let result = dateFormatterResult.string(from: date)

    return result
  }

  public func snakeCaseToTitleCase() -> String {
    return self.replacingOccurrences(of: "_", with: " ").capitalized
  }
}
