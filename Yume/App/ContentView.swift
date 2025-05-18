//
//  ContentView.swift
//  YumeSekai
//
//  Created by Deepanshu Bajaj on 01/05/25.
//

import Anime
import AnimeDetail
import Core
import Common
import Favorite
import Home
import Profile
import Search
import SeeAllAnime
import SwiftUI

struct ContentView: View {
  @EnvironmentObject var homePresenter: HomePresenter<
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
  @EnvironmentObject var searchPresenter: SearchPresenter<
    Interactor<
      AnimeListRequest,
      [AnimeDomainModel],
      SearchAnimeRepository<
        GetAnimeListLocaleDataSource,
        GetAnimeListRemoteDataSource,
        AnimesTransformer>>,
    Interactor<
      AnimeRankingRequest,
      [AnimeDomainModel],
      GetAnimeRankingRepository<
        GetAnimeRankingLocaleDataSource,
        GetAnimeRankingRemoteDataSource,
        AnimesTransformer>>>
  @EnvironmentObject var favoritePresenter: GetListPresenter<
    Int,
    AnimeDomainModel,
    Interactor<
      Int,
      [AnimeDomainModel],
      GetFavoriteAnimesRepository<
        GetFavoriteAnimeLocaleDataSource,
        AnimesTransformer>>>
  @State private var selection: Tab = .home
  @StateObject private var audioViewModel = AudioViewModel()

  init() {
    NetworkMonitor.shared.startMonitoring()

    UITabBar.appearance().isHidden = true
  }

  var body: some View {
    ZStack(alignment: .bottom) {
      ZStack {
        TabView(selection: $selection) {
          NavigationStack {
            HomeView<
              SeeAllAnimeView<AnimeDetailView>,
              AnimeDetailView>(presenter: homePresenter) { rankingType in
                Router().makeSeeAllAnimeView(for: rankingType) { anime in
                  Router().makeAnimeDetailView(for: anime)
                }
              } detailDestination: { anime in
                Router().makeAnimeDetailView(for: anime)
              }
          }.tag(Tab.home)
          NavigationStack {
            SearchView(presenter: searchPresenter) { anime in
              Router().makeAnimeDetailView(for: anime)
            }
          }.tag(Tab.search)
          NavigationStack {
            FavoriteView(presenter: favoritePresenter) { anime in
              Router().makeAnimeDetailView(for: anime)
            }
          }.tag(Tab.favorite)
          NavigationStack {
            ProfileView()
          }.tag(Tab.profile)
        }
        
        // Mute Button overlay
        VStack {
          HStack {
            Spacer()
            MuteButton(viewModel: audioViewModel)
              .padding(.top, 50)
              .padding(.trailing, 20)
          }
          Spacer()
        }
      }
      
      // TabBar at bottom
      TabBar(selection: $selection)
    }
    .ignoresSafeArea(.keyboard)
    .onAppear {
      // Ensure audio continues playing when transitioning from splash screen
      audioViewModel.startPlayback()
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
