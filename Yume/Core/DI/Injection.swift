//
//  Injection.swift
//  YumeSekai
//
//  Created by Deepanshu Bajaj on 02/05/25.
//

import Anime
import Core

import Foundation
import RealmSwift

final class Injection: NSObject {

  private let realm = try? Realm()

  func provideAnimeRanking<U: UseCase>() -> U
  where
  U.Request == AnimeRankingRequest,
  U.Response == [AnimeDomainModel] {
    let locale = GetAnimeRankingLocaleDataSource(realm: realm!)

    let remote = GetAnimeRankingRemoteDataSource(
      endpoint: Endpoints.Gets.ranking.url,
      encoder: API.encoder,
      headers: API.headers
    )

    let mapper = AnimesTransformer()

    let repository = GetAnimeRankingRepository(
      localeDataSource: locale,
      remoteDataSource: remote,
      mapper: mapper)

    return Interactor(repository: repository) as! U
  }

  func provideSearchAnime<U: UseCase>() -> U
  where
  U.Request == AnimeListRequest,
  U.Response == [AnimeDomainModel] {
    let locale = GetAnimeListLocaleDataSource(realm: realm!)

    let remote = GetAnimeListRemoteDataSource(
      endpoint: Endpoints.Gets.search.url,
      encoder: API.encoder,
      headers: API.headers
    )

    let mapper = AnimesTransformer()

    let repository = SearchAnimeRepository(
      localeDataSource: locale,
      remoteDataSource: remote,
      mapper: mapper)

    return Interactor(repository: repository) as! U
  }

  func provideAnime<U: UseCase>() -> U
  where
  U.Request == AnimeRequest,
  U.Response == AnimeDomainModel {
    let locale = GetAnimeLocaleDataSource(realm: realm!)

    let remote = GetAnimeRemoteDataSource(
      endpoint: Endpoints.Gets.detail.url,
      encoder: API.encoder,
      headers: API.headers
    )

    let mapper = AnimeTransformer()

    let repository = GetAnimeRepository(
      localeDataSource: locale,
      remoteDataSource: remote,
      mapper: mapper
    )

    return Interactor(repository: repository) as! U
  }

  func provideUpdateFavoriteAnime<U: UseCase>() -> U
  where
  U.Request == Int,
  U.Response == AnimeDomainModel {
    let locale = GetFavoriteAnimeLocaleDataSource(realm: realm!)

    let mapper = AnimeDataTransformer()

    let repository = UpdateFavoriteAnimeRepository(
      localeDataSource: locale,
      mapper: mapper
    )

    return Interactor(repository: repository) as! U
  }

  func provideFavoriteAnime<U: UseCase>() -> U
  where
  U.Request == Int,
  U.Response == [AnimeDomainModel] {
    let locale = GetFavoriteAnimeLocaleDataSource(realm: realm!)

    let mapper = AnimesTransformer()

    let repository = GetFavoriteAnimesRepository(
      localeDataSource: locale,
      mapper: mapper
    )

    return Interactor(repository: repository) as! U
  }

}
