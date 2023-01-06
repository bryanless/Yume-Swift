//
//  File.swift
//  
//
//  Created by Bryan on 06/01/23.
//

import Combine

public protocol DataSource {
  associatedtype Request
  associatedtype Response

  func execute(request: Request?) -> AnyPublisher<Response, Error>
}
