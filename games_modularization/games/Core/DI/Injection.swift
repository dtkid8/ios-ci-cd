//
//  Injection.swift
//  games
//
//  Created by Eric Theo on 09/12/23.
//

import Foundation
import Core
import Home
import Favorite
import Detail

final class Injection: NSObject {
  func provideDetail() -> DetailUseCase {
    let remote = GetGameDetailRemoteDataSource(_endpoint: Endpoint.detailGame)
    let local = GetGameDetailLocaleDataSource()
    let repository = GetGameDetailRepository(remoteDataSource: remote, localeDataSource: local)
    return DetailInteractor(repository: repository)
  }
  func provideHome<U: UseCase>() -> U where U.Request == Any, U.Response == [GameModel] {
    let remote = GetGameRemoteData(endpoint: Endpoint.listGame)
    let repository = GetGameRepository(remoteDataSource: remote)
    guard let interactor = Interactor(repository: repository) as? U else {
      fatalError("Interactor does not conform to UseCase protocol with Request == Any and Response == [GameModel]")
    }
    return interactor
  }
  func provideFavorite<U: UseCase>() -> U where U.Request == Any, U.Response == [FavoriteGameModel] {
    let locale = GetFavoriteLocaleDataSource()
    let repository = GetFavoriteGameRepository(localeDataSource: locale)
    guard let interactor = Interactor(repository: repository) as? U else {
      fatalError("Interactor does not conform to UseCase protocol with Request == Any and Response == [GameModel]")
    }
    return interactor
  }
}
