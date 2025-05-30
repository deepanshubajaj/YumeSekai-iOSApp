//
//  FavoriteView.swift
//  YumeSekai
//
//  Created by Deepanshu Bajaj on 05/05/25.
//

import Anime
import Common
import Core
import SwiftUI

public struct FavoriteView<DetailDestination: View>: View {
  @ObservedObject var presenter: GetListPresenter<
    Int,
    AnimeDomainModel,
    Interactor<
      Int,
      [AnimeDomainModel],
      GetFavoriteAnimesRepository<
        GetFavoriteAnimeLocaleDataSource,
        AnimesTransformer>>>
  @State var scrollOffset: CGFloat
  let detailDestination: ((_ anime: AnimeDomainModel) -> DetailDestination)

  public init(
    presenter: GetListPresenter<
    Int,
    AnimeDomainModel,
    Interactor<
    Int,
    [AnimeDomainModel],
    GetFavoriteAnimesRepository<
    GetFavoriteAnimeLocaleDataSource,
    AnimesTransformer>>>,
    scrollOffset: CGFloat = CGFloat.zero,
    detailDestination: @escaping (_ anime: AnimeDomainModel) -> DetailDestination) {
    self.presenter = presenter
    self.scrollOffset = scrollOffset
    self.detailDestination = detailDestination
  }

  public var body: some View {
    ZStack {
      if presenter.isLoading {
        ProgressIndicator()
          .background(YumeColor.background)
      } else if presenter.isError {
        Text(presenter.errorMessage)
          .background(YumeColor.background)
      } else if presenter.list.isEmpty {
        empty
      } else {
        content
      }
    }.onAppear {
      presenter.getList(request: nil)
    }
  }
}

extension FavoriteView {
  var empty: some View {
    VStack(alignment: .leading) {
      Text("favorite_title".localized(bundle: .common))
        .typography(.largeTitle(weight: .bold))
      CustomEmptyView(label: "no_favorite_anime_label".localized(bundle: .module))
    }
    .padding(
      EdgeInsets(
        top: 40,
        leading: Space.medium,
        bottom: Space.medium,
        trailing: Space.medium)
    )
    .background(YumeColor.background)
  }

  var content: some View {
    ZStack(alignment: .top) {
      ObservableScrollView(scrollOffset: $scrollOffset, showsIndicators: false) { _ in
        LazyVStack(alignment: .leading, spacing: Space.small) {
          Text("favorite_title".localized(bundle: .common))
            .typography(.largeTitle(weight: .bold))
          ForEach(presenter.list) { anime in
            NavigationLink(destination: detailDestination(anime)) {
              AnimeCardItem(anime: anime)
            }.buttonStyle(.plain)
          }
        }.padding(
          EdgeInsets(
            top: 40,
            leading: Space.medium,
            bottom: Space.medium,
            trailing: Space.medium)
        )
      }
      .background(YumeColor.background)

      AppBar(scrollOffset: scrollOffset, label: "favorite_title".localized(bundle: .common))
    }
  }
}
