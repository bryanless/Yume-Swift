//
//  IconView.swift
//  Yume
//
//  Created by Bryan on 29/12/22.
//

import SwiftUI

struct IconView: View {
  var icon: UIImage
  var color: Color = .black
  var size: CGFloat = IconSize.medium

  var body: some View {
    Image(uiImage: icon)
      .resizable()
      .foregroundColor(color)
      .frame(width: size, height: size)
  }
}

struct IconView_Previews: PreviewProvider {
  static var previews: some View {
    IconView(icon: Icons.trendingUp, color: .green, size: IconSize.large)
  }
}
