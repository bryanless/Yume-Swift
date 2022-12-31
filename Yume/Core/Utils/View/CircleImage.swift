//
//  CircleImage.swift
//  Yume
//
//  Created by Bryan on 31/12/22.
//

import SwiftUI

struct CircleImage: View {
  let image: Image

  var body: some View {
    image
      .resizable()
      .aspectRatio(1, contentMode: .fit)
      .clipShape(Circle())
  }
}

struct CircleImage_Previews: PreviewProvider {
  static var previews: some View {
    CircleImage(image: Image("ProfilePicture"))
  }
}