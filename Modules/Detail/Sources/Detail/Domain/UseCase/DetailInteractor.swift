//
//  File.swift
//  
//
//  Created by Eric Theo on 03/01/24.
//

import Foundation
import Combine
public protocol DetailUseCase {
  func getGameDetail(id: String) -> AnyPublisher<GameDetailModel, Error>
  func addFavoriteGame(game: GameDetailModel) -> AnyPublisher<Bool, Error>
  func deleteFavoriteGame(id: String) -> AnyPublisher<Bool, Error>
  func checkFavoriteGame(id: String) -> AnyPublisher<Bool, Error>
}

public class DetailInteractor: DetailUseCase {
  private let repository: GetGameDetailRepositoryProtocol
  public init(repository: GetGameDetailRepositoryProtocol) {
    self.repository = repository
  }
  public func getGameDetail(id: String) -> AnyPublisher<GameDetailModel, Error> {
    return self.repository.getGameDetail(id: id)
  }
  public func addFavoriteGame(game: GameDetailModel) -> AnyPublisher<Bool, Error> {
    return self.repository.addFavoriteGame(game: game)
  }
  public func deleteFavoriteGame(id: String) -> AnyPublisher<Bool, Error> {
    return self.repository.deleteFavoriteGame(id: id)
  }
  public func checkFavoriteGame(id: String) -> AnyPublisher<Bool, Error> {
    return self.repository.checkFavoriteGame(id: id)
  }
}
