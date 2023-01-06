//
//  File.swift
//  
//
//  Created by Bryan on 07/01/23.
//

import Foundation

extension Double {
  public func reduceScale(to places: Int) -> Double {
    let multiplier = pow(10, Double(places))
    let newDecimal = multiplier * self // move the decimal right
    let truncated = Double(Int(newDecimal)) // drop the fraction
    let originalDecimal = truncated / multiplier // move the decimal back
    return originalDecimal
  }
}
