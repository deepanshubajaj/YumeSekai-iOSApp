//
//  AnimeDataTransformer.swift
//  YumeSekai
//
//  Created by Deepanshu Bajaj on 05/05/25.
//

import Core
import Foundation

public struct AnimeDataTransformer: Mapper {
  public typealias Request = Any
  public typealias Response = AnimeDataResponse
  public typealias Entity = AnimeModuleEntity
  public typealias Domain = AnimeDomainModel

  public init() {}

  public func transformResponseToEntity(request: Any?, response: AnimeDataResponse) -> Entity {
    let animeEntity = AnimeModuleEntity()
    animeEntity.id = response.anime.id
    animeEntity.title = response.anime.title
    animeEntity.mainPicture = response.anime.mainPicture?.medium ?? "Unknown"
    animeEntity.alternativeTitleSynonyms.append(objectsIn: response.anime.alternativeTitles?.synonyms ?? [])
    animeEntity.alternativeTitleEnglish = response.anime.alternativeTitles?.english ?? "Unknown"
    animeEntity.alternativeTitleJapanese = response.anime.alternativeTitles?.japanese ?? "Unknown"
    animeEntity.startDate = response.anime.startDate ?? "Unknown"
    animeEntity.endDate = response.anime.endDate ?? "Unknown"
    animeEntity.synopsis = response.anime.synopsis ?? "Unknown"
    animeEntity.rating = response.anime.rating ?? 0
    animeEntity.rank = response.anime.rank ?? 0
    animeEntity.popularity = response.anime.popularity ?? 0
    animeEntity.userAmount = response.anime.userAmount ?? 0
    animeEntity.favoriteAmount = response.anime.favoriteAmount ?? 0
    animeEntity.nsfw = response.anime.nsfw?.name ?? "Unknown"
    animeEntity.genre.append(objectsIn: response.anime.genres?.map { $0.name } ?? [])
    animeEntity.mediaType = response.anime.mediaType?.name ?? "Unknown"
    animeEntity.status = response.anime.status?.name ?? "Unknown"
    animeEntity.episodeAmount = response.anime.episodeAmount ?? 0
    animeEntity.startSeason = response.anime.startSeason?.season.name ?? "Unknown"
    animeEntity.startSeasonYear = response.anime.startSeason?.year.description ?? ""
    animeEntity.source = response.anime.source?.name ?? "Unknown"
    animeEntity.episodeDuration = response.anime.episodeDuration ?? 0
    animeEntity.studios.append(objectsIn: response.anime.studios?.map { $0.name } ?? [])
    animeEntity.updatedAt = Date()
    return animeEntity
  }

  public func transformEntityToDomain(entity: AnimeModuleEntity) -> AnimeDomainModel {
    return AnimeDomainModel(
      id: entity.id,
      title: entity.title,
      mainPicture: entity.mainPicture,
      alternativeTitleSynonyms: Array(entity.alternativeTitleSynonyms),
      alternativeTitleEnglish: entity.alternativeTitleEnglish,
      alternativeTitleJapanese: entity.alternativeTitleJapanese,
      startDate: entity.startDate,
      endDate: entity.endDate,
      airedDate: AnimeTransformer.transformToAiredDate(startDate: entity.startDate, endDate: entity.endDate),
      synopsis: entity.synopsis,
      rating: entity.rating,
      rank: entity.rank,
      popularity: entity.popularity,
      userAmount: entity.userAmount,
      favoriteAmount: entity.favoriteAmount,
      nsfw: entity.nsfw,
      genre: Array(entity.genre),
      mediaType: entity.mediaType,
      status: entity.status,
      episodeAmount: entity.episodeAmount,
      startSeason: entity.startSeason,
      startSeasonYear: entity.startSeasonYear,
      source: entity.source,
      episodeDuration: entity.episodeDuration,
      episodeDurationText: AnimeTransformer.transformToDurationText(duration: entity.episodeDuration),
      studios: Array(entity.studios),
      isFavorite: entity.isFavorite
    )
  }

}
