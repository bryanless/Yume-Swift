//
//  AnimeListModuleRequest.swift
//  
//
//  Created by Bryan on 08/01/23.
//

public struct AnimeListRequest: Encodable {
  let q: String
  let limit: Int?
  let offset: Int?
  let fields: String?
  let nsfw: Bool?
  let refresh: Bool

  public init(
    title q: String,
    limit: Int? = nil,
    offset: Int? = nil,
    fields: String? = nil,
    nsfw: Bool? = nil,
    refresh: Bool = false
  ) {
    self.q = q
    self.limit = limit
    self.offset = offset
    self.fields = fields
    self.nsfw = nsfw
    self.refresh = refresh
  }
}
