//
//  SeeAllAnimeView.swift
//  YumeSekai
//
//  Created by Deepanshu Bajaj on 05/05/25.
//

import Anime
import Common
import Core
import SwiftUI

public struct SeeAllAnimeView<DetailDestination: View>: View {

  @ObservedObject var presenter: GetListPresenter<
    AnimeRankingRequest,
    AnimeDomainModel,
    Interactor<
      AnimeRankingRequest,
      [AnimeDomainModel],
      GetAnimeRankingRepository<
        GetAnimeRankingLocaleDataSource,
        GetAnimeRankingRemoteDataSource,
        AnimesTransformer>>>
  @State var scrollOffset: CGFloat
  let rankingType: RankingTypeRequest
  let navigationTitle: String
  let detailDestination: ((_ anime: AnimeDomainModel) -> DetailDestination)

  public init(
    presenter: GetListPresenter<
    AnimeRankingRequest,
    AnimeDomainModel,
    Interactor<
    AnimeRankingRequest,
    [AnimeDomainModel],
    GetAnimeRankingRepository<
    GetAnimeRankingLocaleDataSource,
    GetAnimeRankingRemoteDataSource,
    AnimesTransformer>>>,
    scrollOffset: CGFloat = CGFloat.zero,
    rankingType: RankingTypeRequest,
    navigationTitle: String,
    detailDestination: @escaping (_ anime: AnimeDomainModel) -> DetailDestination
  ) {
    self.presenter = presenter
    self.scrollOffset = scrollOffset
    self.rankingType = rankingType
    self.navigationTitle = navigationTitle
    self.detailDestination = detailDestination
  }

  public var body: some View {
    ZStack {
      if presenter.isLoading {
        ProgressIndicator()
          .background(YumeColor.background)
      } else if presenter.isError {
        CustomEmptyView(label: presenter.errorMessage)
      } else {
        content
      }
    }
    .toolbar(.hidden)
    .onAppear {
      if presenter.list.isEmpty {
        presenter.getList(request: AnimeRankingRequest(type: rankingType))
      }
    }
  }
}

extension SeeAllAnimeView {
  var content: some View {
    ZStack(alignment: .top) {
      ObservableScrollView(scrollOffset: $scrollOffset, showsIndicators: false) { _ in
        LazyVStack(spacing: Space.small) {
          ForEach(presenter.list.prefix(20)) { anime in
            NavigationLink(destination: detailDestination(anime)) {
              AnimeCardItem(anime: anime)
            }.buttonStyle(.plain)
          }
        }
        .padding(
          EdgeInsets(
            top: 56,
            leading: Space.medium,
            bottom: Space.medium,
            trailing: Space.medium)
        )
      }.background(YumeColor.background)

      BackAppBar(scrollOffset: scrollOffset, label: navigationTitle.localized(bundle: .common), alwaysShowLabel: true)
    }
  }
}
