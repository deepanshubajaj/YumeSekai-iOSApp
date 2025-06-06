//
//  AnimePresenter.swift
//  YumeSekai
//
//  Created by Deepanshu Bajaj on 05/05/25.
//

import Combine
import Core
import Foundation

public class AnimePresenter<
  AnimeUseCase: UseCase,
  FavoriteUseCase: UseCase>: ObservableObject
where AnimeUseCase.Request == AnimeRequest,
      AnimeUseCase.Response == AnimeDomainModel,
      FavoriteUseCase.Request == Int,
      FavoriteUseCase.Response == AnimeDomainModel {

  private var cancellables: Set<AnyCancellable> = []

  private let _animeUseCase: AnimeUseCase
  private let _favoriteUseCase: FavoriteUseCase

  @Published public var item: AnimeDomainModel?
  @Published public var errorMessage: String = ""
  @Published public var isLoading: Bool = false
  @Published public var isError: Bool = false

  public init(
    animeUseCase: AnimeUseCase,
    favoriteUseCase: FavoriteUseCase
  ) {
    _animeUseCase = animeUseCase
    _favoriteUseCase = favoriteUseCase
  }

  public func getAnime(request: AnimeUseCase.Request) {
    isLoading = true
    _animeUseCase.execute(request: request)
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure(let error):
          self.errorMessage = error.localizedDescription
          self.isError = true
          self.isLoading = false
        case .finished:
          self.isLoading = false
        }
      }, receiveValue: { item in
        self.isError = false

        var anime = item

        anime.startDate = item.startDate.apiFullStringDateToFullStringDate()
        anime.endDate = item.endDate.apiFullStringDateToFullStringDate()

        self.item = anime
      })
      .store(in: &cancellables)
  }

  public func updateFavoriteAnime(request: FavoriteUseCase.Request) {
    _favoriteUseCase.execute(request: request)
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure(let error):
          self.errorMessage = error.localizedDescription
          self.isError = true
          self.isLoading = false
        case .finished:
          self.isLoading = false
        }
      }, receiveValue: { item in
        self.isError = false
        self.item = item
      })
      .store(in: &cancellables)
  }
}
