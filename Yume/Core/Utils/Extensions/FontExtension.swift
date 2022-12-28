//
//  FontExtension.swift
//  Yume
//
//  Created by Bryan on 29/12/22.
//

import SwiftUI

// Credit: https://medium.com/@farhanadji/how-to-improve-text-font-style-consistency-in-swiftui-11d2b1085289
extension Font {
  static func nunitoFont(size: CGFloat, weight: Font.Weight =  .regular) -> Font {
    var fontName = "Nunito-Regular"
    if weight == .bold {
      fontName = "Nunito-SemiBold"
    }
    return .custom(fontName, size: size)
  }

}

enum TypographyStyle {
  case largeTitle(color: Color = .black)
  case title(color: Color = .black)
  case title2(color: Color = .black)
  case title3(color: Color = .black)
  case headline(color: Color = .black)
  case body(color: Color = .black)
  case callout(color: Color = .black)
  case subheadline(color: Color = .black)
  case footnote(color: Color = .black)
  case caption(color: Color = .black)
  case caption2(color: Color = .black)

  public var size: CGFloat {
    switch self {
    case .largeTitle:
      return 34
    case .title:
      return 28
    case .title2:
      return 22
    case .title3:
      return 20
    case .headline:
      return 17
    case .body:
      return 17
    case .callout:
      return 16
    case .subheadline:
      return 15
    case .footnote:
      return 13
    case .caption:
      return 12
    case .caption2:
      return 11
    }
  }
  public var weight: Font.Weight {
    switch self {
    case .largeTitle, .title, .title2, .title3,
        .body, .callout, .subheadline,
        .footnote, .caption, .caption2:
      return .regular
    case .headline:
      return .bold
    }
  }
}

struct BaseTypography: ViewModifier {
  let type: TypographyStyle
  let color: Color

  func body(content: Content) -> some View {
    content
      .font(.nunitoFont(size: type.size, weight: type.weight))
      .foregroundColor(color)
  }

  init(type: TypographyStyle, color: Color = .black) {
    self.type = type
    self.color = color
  }
}

extension View {
  func typography(_ type: TypographyStyle) -> some View {
    switch type {
    case .largeTitle(let color), .title(let color), .title2(let color),
        .title3(let color), .headline(let color), .body(let color),
        .callout(let color), .subheadline(let color), .footnote(let color),
        .caption(let color), .caption2(let color):
      return self.modifier(BaseTypography(type: type, color: color))
    }
  }
}
