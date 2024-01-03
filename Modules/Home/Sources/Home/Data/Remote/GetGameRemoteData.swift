//
//  File.swift
//
//
//  Created by Eric Theo on 02/01/24.
//

import Foundation
import Core
import Alamofire
import Combine

public struct GetGameRemoteData: RemoteDataSource{
  public typealias Request = Any
  
  public typealias Response = GameEntity
  
  private let _endpoint: String
  
  public init(endpoint: String) {
    _endpoint = endpoint
  }
  
  public func execute(request: Request?) -> AnyPublisher<GameEntity, Error> {
        return Future<GameEntity, Error> { completion in
          guard let url = URL(string: self._endpoint) else { return }
          let parameters: Parameters = [ "key": "77b984902864411694a5252916058b42" ]
          AF.request(url, parameters: parameters).validate().responseDecodable(of: GameEntity.self) { response in
            switch response.result {
            case .success(let value): completion(.success(value))
            case .failure: completion(.failure(URLError.invalidResponse))
            }
          }
        }.eraseToAnyPublisher()
  }
}
