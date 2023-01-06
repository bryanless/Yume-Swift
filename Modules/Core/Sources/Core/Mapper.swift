//
//  File.swift
//  
//
//  Created by Bryan on 06/01/23.
//

public protocol Mapper {
  associatedtype Response
  associatedtype Entity
  associatedtype Domain

  func transformResponseToEntity(response: Response) -> Entity
  func transformEntityToDomain(entity: Entity) -> Domain
}
