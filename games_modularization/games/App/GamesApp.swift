//
//  gamesApp.swift
//  games
//
//  Created by Eric Theo on 27/11/23.
//

import SwiftUI
import Core
import Home
import Favorite
let homeUseCase: Interactor<
  Any,
  [GameModel],
  GetGameRepository<GetGameRemoteData>
> = Injection.init().provideHome()
let favoriteUseCase: Interactor<
  Any,
  [FavoriteGameModel],
  GetFavoriteGameRepository<GetFavoriteLocaleDataSource>
> = Injection.init().provideFavorite()
@main
struct GamesApp: App {
  let homePresenter = GetListPresenter(useCase: homeUseCase)
  let favoritePresenter = GetListPresenter(useCase: favoriteUseCase)
    var body: some Scene {
        WindowGroup {
          AppView()
          .environmentObject(homePresenter)
          .environmentObject(favoritePresenter)
        }
    }
}
