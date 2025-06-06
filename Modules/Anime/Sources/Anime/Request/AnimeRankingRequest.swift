//
//  AnimeRankingRequest.swift
//  YumeSekai
//
//  Created by Deepanshu Bajaj on 05/05/25.
//

public struct AnimeRankingRequest {
  let rankingType: RankingTypeRequest
  let limit: Int?
  let offset: Int?
  let fields: String?
  let nsfw: Bool?
  let refresh: Bool

  public init(
    type rankingType: RankingTypeRequest,
    limit: Int? = nil,
    offset: Int? = nil,
    fields: String? = nil,
    nsfw: Bool? = nil,
    refresh: Bool = false
  ) {
    self.rankingType = rankingType
    self.limit = limit
    self.offset = offset
    self.fields = fields
    self.nsfw = nsfw
    self.refresh = refresh
  }
}

public enum RankingTypeRequest: String {
  case all
  case airing
  case upcoming
  case tv
  case ova
  case movie
  case special
  case byPopularity
  case favorite

  var name: String {
    return rawValue.lowercased()
  }

  var sortKey: String {
    switch self {
    case .all, .airing, .tv, .ova, .movie, .special:
      return "rank"
    case .upcoming, .byPopularity:
      return "popularity"
    case .favorite:
      return "favoriteAmount"
    }
  }
}
