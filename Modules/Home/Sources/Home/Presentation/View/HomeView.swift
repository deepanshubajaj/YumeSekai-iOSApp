//
//  HomeView.swift
//  YumeSekai
//
//  Created by Deepanshu Bajaj on 05/05/25.
//

import Anime
import Common
import Core
import SwiftUI

public struct HomeView<SeeAllDestination: View, DetailDestination: View>: View {
  @State private var showSnackbar = false
  @State private var restartSnackbar = false

  @ObservedObject var presenter: HomePresenter<
    Interactor<
      AnimeRankingRequest,
      [AnimeDomainModel],
      GetAnimeRankingRepository<
        GetAnimeRankingLocaleDataSource,
        GetAnimeRankingRemoteDataSource,
        AnimesTransformer>>,
    Interactor<
      AnimeRankingRequest,
      [AnimeDomainModel],
      GetAnimeRankingRepository<
        GetAnimeRankingLocaleDataSource,
        GetAnimeRankingRemoteDataSource,
        AnimesTransformer>>,
    Interactor<
      AnimeRankingRequest,
      [AnimeDomainModel],
      GetAnimeRankingRepository<
        GetAnimeRankingLocaleDataSource,
        GetAnimeRankingRemoteDataSource,
        AnimesTransformer>>,
    Interactor<
      AnimeRankingRequest,
      [AnimeDomainModel],
      GetAnimeRankingRepository<
        GetAnimeRankingLocaleDataSource,
        GetAnimeRankingRemoteDataSource,
        AnimesTransformer>>>
  @State var scrollOffset: CGFloat
  let seeAllDestination: ((_ rankingType: RankingTypeRequest) -> SeeAllDestination)
  let detailDestination: ((_ anime: AnimeDomainModel) -> DetailDestination)

  public init(
    presenter: HomePresenter<
    Interactor<
    AnimeRankingRequest,
    [AnimeDomainModel],
    GetAnimeRankingRepository<
    GetAnimeRankingLocaleDataSource,
    GetAnimeRankingRemoteDataSource,
    AnimesTransformer>>,
    Interactor<
    AnimeRankingRequest,
    [AnimeDomainModel],
    GetAnimeRankingRepository<
    GetAnimeRankingLocaleDataSource,
    GetAnimeRankingRemoteDataSource,
    AnimesTransformer>>,
    Interactor<
    AnimeRankingRequest,
    [AnimeDomainModel],
    GetAnimeRankingRepository<
    GetAnimeRankingLocaleDataSource,
    GetAnimeRankingRemoteDataSource,
    AnimesTransformer>>,
    Interactor<
    AnimeRankingRequest,
    [AnimeDomainModel],
    GetAnimeRankingRepository<
    GetAnimeRankingLocaleDataSource,
    GetAnimeRankingRemoteDataSource,
    AnimesTransformer>>>,
    scrollOffset: CGFloat = CGFloat.zero,
    seeAllDestination: @escaping ((RankingTypeRequest) -> SeeAllDestination),
    detailDestination: @escaping ((AnimeDomainModel) -> DetailDestination)
  ) {
    self.presenter = presenter
    self.scrollOffset = scrollOffset
    self.seeAllDestination = seeAllDestination
    self.detailDestination = detailDestination
  }

  public var body: some View {
    ZStack {
      if presenter.isLoading {
        ProgressIndicator()
          .background(YumeColor.background)
      } else if presenter.isError {
        if presenter.errorMessage == URLError.notConnectedToInternet.localizedDescription {
          NoInternetView(onRetry: presenter.retryConnection)
        } else {
          CustomEmptyView(label: presenter.errorMessage)
        }
      } else {
        content
      }
    }.onAppear {
      if presenter.topAiringAnimeList.isEmpty
          || presenter.topUpcomingAnimeList.isEmpty
          || presenter.popularAnimeList.isEmpty
          || presenter.topAllAnimeList.isEmpty {
        presenter.setupHomeView()
      }
    }
  }
}

extension HomeView {
  var content: some View {
    ZStack(alignment: .top) {
      RefreshableScrollView(
        scrollOffset: $scrollOffset,
        showsIndicators: false,
        isRefreshing: $presenter.isRefreshing,
        onRefresh: presenter.refreshHomeView
      ) { _ in
        LazyVStack(spacing: Space.large) {
          header
          topAiringAnime
          topUpcomingAnime
          popularAnime
          topAllAnime
        }.padding(
          EdgeInsets(
            top: 40,
            leading: Space.none,
            bottom: Space.medium,
            trailing: Space.none)
        )
      }

      AppBar(scrollOffset: scrollOffset, label: "home_title".localized(bundle: .common))
    }
    .background(YumeColor.background)
    .onChange(of: presenter.showSnackbar) { presenterShowSnackbar in
      if presenterShowSnackbar {
        withAnimation(.easeInOut) {
          if showSnackbar {
            restartSnackbar = true
          }
          showSnackbar = true
        }
        presenter.showSnackbar = false
      }
    }
    .snackbar(
      message: presenter.errorMessage,
      withCloseIcon: true,
      isShowing: $showSnackbar,
      restart: $restartSnackbar)
  }

  var header: some View {
    HStack {
      Text("home_title".localized(bundle: .common))
        .typography(.largeTitle(weight: .bold, color: YumeColor.onBackground))
      Spacer()
    }.padding(.horizontal, Space.medium)
  }

  var topAiringAnime: some View {
    VStack(spacing: Space.small) {
      HStack(spacing: Space.small) {
        Text("now_airing_title".localized(bundle: .common))
          .typography(.headline(color: YumeColor.onBackground))
        Spacer()
        NavigationLink(destination: seeAllDestination(.airing)) {
          Text("see_all_label".localized(bundle: .module))
            .typography(.subheadline(color: YumeColor.primary))
        }.buttonStyle(.plain)
      }.padding(.horizontal, Space.medium)

      ScrollView(.horizontal, showsIndicators: false) {
        LazyHStack(spacing: Space.small) {
          ForEach(presenter.topAiringAnimeList.prefix(10)) { anime in
            NavigationLink(destination: detailDestination(anime)) {
              AnimeItem(anime: anime)
            }.buttonStyle(.plain)
          }
        }.padding(.horizontal, Space.medium)
      }
    }
  }

  var topUpcomingAnime: some View {
    VStack(spacing: Space.small) {
      HStack(spacing: Space.small) {
        Text("upcoming_title".localized(bundle: .common))
          .typography(.headline(color: YumeColor.onBackground))
        Spacer()
        NavigationLink(destination: seeAllDestination(.upcoming)) {
          Text("see_all_label".localized(bundle: .module))
            .typography(.subheadline(color: YumeColor.primary))
        }.buttonStyle(.plain)
      }.padding(.horizontal, Space.medium)

      ScrollView(.horizontal, showsIndicators: false) {
        LazyHStack(spacing: Space.small) {
          ForEach(presenter.topUpcomingAnimeList.prefix(10)) { anime in
            NavigationLink(destination: detailDestination(anime)) {
              AnimeItem(anime: anime)
            }.buttonStyle(.plain)
          }
        }.padding(.horizontal, Space.medium)
      }
    }
  }

  var popularAnime: some View {
    VStack(spacing: Space.small) {
      HStack(spacing: Space.small) {
        Text("most_popular_title".localized(bundle: .common))
          .typography(.headline(color: YumeColor.onBackground))
        Spacer()
        NavigationLink(destination: seeAllDestination(.byPopularity)) {
          Text("see_all_label".localized(bundle: .module))
            .typography(.subheadline(color: YumeColor.primary))
        }.buttonStyle(.plain)
      }.padding(.horizontal, Space.medium)

      ScrollView(.horizontal, showsIndicators: false) {
        LazyHStack(spacing: Space.small) {
          ForEach(presenter.popularAnimeList.prefix(10)) { anime in
            NavigationLink(destination: detailDestination(anime)) {
              AnimeItem(anime: anime)
            }.buttonStyle(.plain)
          }
        }.padding(.horizontal, Space.medium)
      }
    }
  }

  var topAllAnime: some View {
    VStack(spacing: Space.small) {
      HStack(spacing: Space.small) {
        Text("top_rated_title".localized(bundle: .common))
          .typography(.headline(color: YumeColor.onBackground))
        Spacer()
        NavigationLink(destination: seeAllDestination(.all)) {
          Text("see_all_label".localized(bundle: .module))
            .typography(.subheadline(color: YumeColor.primary))
        }.buttonStyle(.plain)
      }.padding(.horizontal, Space.medium)

      ScrollView(.horizontal, showsIndicators: false) {
        LazyHStack(spacing: Space.small) {
          ForEach(presenter.topAllAnimeList.prefix(10)) { anime in
            NavigationLink(destination: detailDestination(anime)) {
              AnimeItem(anime: anime)
            }.buttonStyle(.plain)
          }
        }.padding(.horizontal, Space.medium)
      }
    }
  }
}
