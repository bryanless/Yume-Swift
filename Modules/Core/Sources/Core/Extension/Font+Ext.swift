//
//  Font+Ext.swift
//  
//
//  Created by Bryan on 07/01/23.
//

import SwiftUI

// Credit: https://medium.com/@farhanadji/how-to-improve-text-font-style-consistency-in-swiftui-11d2b1085289
extension Font {
  public static func nunitoFont(size: CGFloat, weight: Font.Weight = .regular) -> Font {
    var fontName = "Nunito-Regular"
    if weight == .bold {
      fontName = "Nunito-SemiBold"
    }
    return .custom(fontName, size: size)
  }

}

public enum TypographyStyle {
  case largeTitle(weight: Font.Weight = .regular, color: Color = YumeColor.onBackground)
  case title(weight: Font.Weight = .regular, color: Color = YumeColor.onBackground)
  case title2(weight: Font.Weight = .regular, color: Color = YumeColor.onBackground)
  case title3(weight: Font.Weight = .regular, color: Color = YumeColor.onBackground)
  case headline(weight: Font.Weight = .bold, color: Color = YumeColor.onBackground)
  case body(weight: Font.Weight = .regular, color: Color = YumeColor.onBackground)
  case callout(weight: Font.Weight = .regular, color: Color = YumeColor.onBackground)
  case subheadline(weight: Font.Weight = .regular, color: Color = YumeColor.onBackground)
  case footnote(weight: Font.Weight = .regular, color: Color = YumeColor.onBackground)
  case caption(weight: Font.Weight = .regular, color: Color = YumeColor.onBackground)
  case caption2(weight: Font.Weight = .regular, color: Color = YumeColor.onBackground)

  var size: CGFloat {
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

  var weight: Font.Weight {
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
  let weight: Font.Weight
  let color: Color

  func body(content: Content) -> some View {
    content
      .font(.nunitoFont(size: type.size, weight: weight))
      .foregroundColor(color)
  }

  init(type: TypographyStyle, weight: Font.Weight, color: Color = YumeColor.onBackground) {
    self.type = type
    self.weight = weight
    self.color = color
  }
}

extension View {
  public func typography(_ type: TypographyStyle) -> some View {
    switch type {
    case .largeTitle(let weight, let color),
        .title(let weight, let color),
        .title2(let weight, let color),
        .title3(let weight, let color),
        .headline(let weight, let color),
        .body(let weight, let color),
        .callout(let weight, let color),
        .subheadline(let weight, let color),
        .footnote(let weight, let color),
        .caption(let weight, let color),
        .caption2(let weight, let color):
      return self.modifier(BaseTypography(type: type, weight: weight, color: color))
    }
  }
}
