//
//  StringExtension.swift
//  Yume
//
//  Created by Bryan on 06/01/23.
//

import Foundation

extension String {
  func containsWords(_ words: String, caseInsensitive: Bool = true) -> Bool {
    // Check if it should be case insensitive
    let firstString = caseInsensitive ? self.lowercased() : self
    let secondString = caseInsensitive ? words.lowercased() : words

    // Trim whitespaces, split by dash, joined by whitespace, remove punctuation, split by whitespace
    let firstStringCharacters = firstString
      .trimmingCharacters(in: .whitespacesAndNewlines)
      .split(separator: "-")
      .joined(separator: " ")
      .trimmingCharacters(in: .punctuationCharacters)
      .split(separator: " ")
    let secondStringCharacters = secondString.filter { !$0.isPunctuation }
      .trimmingCharacters(in: .whitespacesAndNewlines)
      .split(separator: "-")
      .joined(separator: " ")
      .trimmingCharacters(in: .punctuationCharacters)
      .split(separator: " ")

    return secondStringCharacters.allSatisfy { secondCharacter in
      firstStringCharacters.contains(where: { $0.hasPrefix(secondCharacter)  })
    }
  }
}
