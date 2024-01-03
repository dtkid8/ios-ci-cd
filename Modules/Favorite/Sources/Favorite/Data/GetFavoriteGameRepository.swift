//
//  File.swift
//  
//
//  Created by Eric Theo on 03/01/24.
//

import Foundation
import Core
import Foundation
import Combine

public struct GetFavoriteGameRepository<
  Locale: LocaleDataSource
>: Repository where
Locale.Response == FavoriteGameModel{
  public typealias Request = Any
  public typealias Response = [FavoriteGameModel]
  private let _localeDataSource: Locale
  public init(
    localeDataSource: Locale
  ) {
    _localeDataSource = localeDataSource
  }
  
  public func execute(request: Request?) -> AnyPublisher<[FavoriteGameModel], Error> {
        return _localeDataSource.list(request: nil)
            .eraseToAnyPublisher()
  }
}
