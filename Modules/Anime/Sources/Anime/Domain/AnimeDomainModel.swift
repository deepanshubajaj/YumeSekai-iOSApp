//
//  AnimeDomainModel.swift
//  YumeSekai
//
//  Created by Deepanshu Bajaj on 05/05/25.
//

public struct AnimeDomainModel: Equatable, Identifiable {

  public let id: Int
  public let title: String
  public let mainPicture: String
  public let alternativeTitleSynonyms: [String]
  public let alternativeTitleEnglish: String
  public let alternativeTitleJapanese: String
  public var startDate: String
  public var endDate: String
  public let airedDate: String
  public let synopsis: String
  public let rating: Double
  public let rank: Int
  public let popularity: Int
  public let userAmount: Int
  public let favoriteAmount: Int
  public let nsfw: String
  public let genre: [String]
  public let mediaType: String
  public let status: String
  public let episodeAmount: Int
  public let startSeason: String
  public let startSeasonYear: String
  public let source: String
  public let episodeDuration: Int
  public let episodeDurationText: String
  public let studios: [String]
  public var isFavorite: Bool

}
