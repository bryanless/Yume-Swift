//
//  File.swift
//  
//
//  Created by Bryan on 06/01/23.
//

import Combine

public protocol Repository {
  associatedtype Request
  associatedtype Response

  func execute(request: Request?) -> AnyPublisher<Response, Error>
}
