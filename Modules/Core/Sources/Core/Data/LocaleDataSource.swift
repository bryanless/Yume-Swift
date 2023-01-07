//
//  File.swift
//  
//
//  Created by Bryan on 06/01/23.
//

import Combine

public protocol LocaleDataSource {
  associatedtype Request
  associatedtype Response

  func list(request: Request?) -> AnyPublisher<[Response], Error>
  func add(entities: [Response]) -> AnyPublisher<Bool, Error>
  func get(id: Int) -> AnyPublisher<Response, Error>
  func update(id: Int, entity: Response) -> AnyPublisher<Bool, Error>
}
