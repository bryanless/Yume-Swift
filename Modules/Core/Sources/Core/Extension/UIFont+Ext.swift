//
//  UIFont+Ext.swift
//  
//
//  Created by Bryan on 09/01/23.
//

import UIKit

extension UIFont {
  private static func registerFont(withName name: String, fileExtension: String) {
    let frameworkBundle = Bundle.module
    let pathForResourceString = frameworkBundle.path(forResource: name, ofType: fileExtension)!
    let fontData = NSData(contentsOfFile: pathForResourceString)
    let dataProvider = CGDataProvider(data: fontData!)
    let fontRef = CGFont(dataProvider!)
    var errorRef: Unmanaged<CFError>?

    if CTFontManagerRegisterGraphicsFont(fontRef!, &errorRef) == false {
      print("Error registering font")
    }
  }

  public static func loadFonts() {
    registerFont(withName: "Nunito-Regular", fileExtension: "ttf")
    registerFont(withName: "Nunito-SemiBold", fileExtension: "ttf")
  }
}
