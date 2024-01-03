//
//  File.swift
//
//
//  Created by Eric Theo on 02/01/24.
//
import Core
import Foundation
import Combine

public struct GetGameRepository<
  Remote: RemoteDataSource
>: Repository where
Remote.Response == GameEntity{
  public typealias Request = Any
  public typealias Response = [GameModel]
  private let _remoteDataSource: Remote
  public init(
    remoteDataSource: Remote
  ) {
    _remoteDataSource = remoteDataSource
  }
  public func execute(request: Any?) -> AnyPublisher<[GameModel], Error> {
    return _remoteDataSource.execute(request: nil)
        .map { GameModel.mapGameEntityToModel(input: $0)
        }.eraseToAnyPublisher()
  }
}
