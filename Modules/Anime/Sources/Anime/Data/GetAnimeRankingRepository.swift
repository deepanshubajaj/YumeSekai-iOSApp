//
//  GetAnimeRankingRepository.swift
//  YumeSekai
//
//  Created by Deepanshu Bajaj on 05/05/25.
//

import Combine
import Core

public struct GetAnimeRankingRepository<
  AnimeLocaleDataSource: LocaleDataSource,
  RemoteDataSource: DataSource,
  Transformer: Mapper>: Repository
where AnimeLocaleDataSource.Request == AnimeRankingRequest,
      AnimeLocaleDataSource.Response == AnimeModuleEntity,
      RemoteDataSource.Request == AnimeRankingRequest,
      RemoteDataSource.Response == [AnimeDataResponse],
      Transformer.Request == Any,
      Transformer.Response == [AnimeDataResponse],
      Transformer.Entity == [AnimeModuleEntity],
      Transformer.Domain == [AnimeDomainModel] {

  public typealias Request = AnimeRankingRequest
  public typealias Response = [AnimeDomainModel]

  private let _localeDataSource: AnimeLocaleDataSource
  private let _remoteDataSource: RemoteDataSource
  private let _mapper: Transformer

  public init(
    localeDataSource: AnimeLocaleDataSource,
    remoteDataSource: RemoteDataSource,
    mapper: Transformer) {
      _localeDataSource = localeDataSource
      _remoteDataSource = remoteDataSource
      _mapper = mapper
    }

  public func execute(request: AnimeRankingRequest?) -> AnyPublisher<[AnimeDomainModel], Error> {
    guard let request = request else {
      fatalError("Request cannot be empty")
    }

    return _localeDataSource.list(request: request)
      .flatMap { result -> AnyPublisher<[AnimeDomainModel], Error> in
        if result.isEmpty || request.refresh {
          return _remoteDataSource.execute(request: request)
            .map { _mapper.transformResponseToEntity(request: request, response: $0) }
            .flatMap { _localeDataSource.add(entities: $0) }
            .filter { $0 }
            .flatMap { _ in _localeDataSource.list(request: request)
                .map { _mapper.transformEntityToDomain(entity: $0) }
            }
            .catch { error in
              if result.isEmpty {
                // First time request and no cache
                return Fail<[AnimeDomainModel], Error>(error: error)
                  .eraseToAnyPublisher()
              } else {
                // Failed to refresh
                return _localeDataSource.list(request: request)
                  .map { _mapper.transformEntityToDomain(entity: $0) }
                  .eraseToAnyPublisher()
              }
            }
            .eraseToAnyPublisher()
        } else {
          return _localeDataSource.list(request: request)
            .map { _mapper.transformEntityToDomain(entity: $0) }
            .eraseToAnyPublisher()
        }
      }.eraseToAnyPublisher()
  }

}
