//
//  File.swift
//  
//
//  Created by Eric Theo on 03/01/24.
//

import Foundation
import Core
import Combine

public protocol GetGameDetailRepositoryProtocol {
  func getGameDetail(id: String) -> AnyPublisher<GameDetailModel, Error>
  func addFavoriteGame(game: GameDetailModel) -> AnyPublisher<Bool, Error>
  func deleteFavoriteGame(id: String) -> AnyPublisher<Bool, Error>
  func checkFavoriteGame(id: String) -> AnyPublisher<Bool, Error>
}

public struct GetGameDetailRepository : GetGameDetailRepositoryProtocol
{
  private let _remoteDataSource: GetGameDetailRemoteDataSource
  private let _localeDataSource: GetGameDetailLocaleDataSource
  public init(
    remoteDataSource: GetGameDetailRemoteDataSource,
    localeDataSource: GetGameDetailLocaleDataSource
  ){
    _remoteDataSource = remoteDataSource
    _localeDataSource = localeDataSource
  }
  public func getGameDetail(id: String) -> AnyPublisher<GameDetailModel, Error> {
    return _remoteDataSource.execute(request: nil, id: id)
        .map { GameDetailModel.mapGameDetailEntityToModel(entity: $0)
        }.eraseToAnyPublisher()
  }
  
  public func addFavoriteGame(game: GameDetailModel) -> AnyPublisher<Bool, Error> {
    return _localeDataSource.addFavoriteGame(game: game)
      .map { Bool($0)
      }.eraseToAnyPublisher()
  }
  
  public func deleteFavoriteGame(id: String) -> AnyPublisher<Bool, Error> {
    return _localeDataSource.deleteFavoriteGame(id: id)
      .map { Bool($0)
      }.eraseToAnyPublisher()
  }
  
  public func checkFavoriteGame(id: String) -> AnyPublisher<Bool, Error> {
    return _localeDataSource.checkFavoriteGame(id: id)
      .map { Bool($0)
      }.eraseToAnyPublisher()
  }
}
