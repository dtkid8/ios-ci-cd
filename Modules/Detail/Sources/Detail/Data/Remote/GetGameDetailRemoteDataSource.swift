//
//  File.swift
//  
//
//  Created by Eric Theo on 03/01/24.
//

import Foundation
import Core
import Alamofire
import Combine

public struct GetGameDetailRemoteDataSource: RemoteDataSource{
  public typealias Request = Any
  public typealias Response = GameDetailEntity
  private let _endpoint: String
  public init(_endpoint: String) {
    self._endpoint = _endpoint
  }
  public func execute(request: Request?) -> AnyPublisher<GameDetailEntity, Error> {
    fatalError()
  }
  public func execute(request: Request?, id: String) -> AnyPublisher<GameDetailEntity, Error> {
    return Future<GameDetailEntity, Error> { completion in
      guard let url = URL(string: _endpoint.replacingOccurrences(of: ":id", with: id)) else {
        return
      }
      let parameters: Parameters = [ "key": "77b984902864411694a5252916058b42" ]
      AF.request(url, parameters: parameters).validate().responseDecodable(of: GameDetailEntity.self) { response in
        switch response.result {
        case .success(let value): completion(.success(value))
        case .failure: completion(.failure(URLError.invalidResponse))
        }
      }
    }.eraseToAnyPublisher()
  }
}
