//
//  AppView.swift
//  games
//
//  Created by Eric Theo on 20/12/23.
//

import SwiftUI
import Core
import Home
import Favorite

struct AppView: View {
  @EnvironmentObject var homePresenter: GetListPresenter<Any, GameModel, Interactor<Any, [GameModel], GetGameRepository<GetGameRemoteData>>>
  @EnvironmentObject var favoritePresenter: GetListPresenter<Any, FavoriteGameModel, Interactor<Any, [FavoriteGameModel], GetFavoriteGameRepository<GetFavoriteLocaleDataSource>>>
  var body: some View {
    TabView {
      HomeView(presenter: homePresenter).tabItem({
        Label("Home", systemImage: "house.circle")
      })
      .toolbar(.visible, for: .tabBar)
      .toolbarBackground(Color.black.opacity(0.9), for: .tabBar)
      FavoriteView(presenter: favoritePresenter).tabItem({
        Label("Favorite", systemImage: "heart.circle")
      })
      .toolbar(.visible, for: .tabBar)
      .toolbarBackground(Color.black.opacity(0.9), for: .tabBar)
      ProfileView().tabItem({
        Label("Profile", systemImage: "person.circle")
      })
      .toolbar(.visible, for: .tabBar)
      .toolbarBackground(Color.black.opacity(0.9), for: .tabBar)
    }
  }
}

#Preview {
  let homeUseCase: Interactor<
    Any,
    [GameModel],
    GetGameRepository<GetGameRemoteData>
  > = Injection.init().provideHome()
  let homePresenter = GetListPresenter(useCase: homeUseCase)
  let favoriteUseCase: Interactor<
    Any,
    [FavoriteGameModel],
    GetFavoriteGameRepository<GetFavoriteLocaleDataSource>
  > = Injection.init().provideFavorite()
  let favoritePresenter = GetListPresenter(useCase: favoriteUseCase)
  return AppView()
  .environmentObject(homePresenter)
  .environmentObject(favoritePresenter)
}
