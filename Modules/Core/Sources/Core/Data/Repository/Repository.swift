//
//  File.swift
//  
//
//  Created by Eric Theo on 02/01/24.
//

import Foundation
import Combine
 
public protocol Repository {
    associatedtype Request
    associatedtype Response
    
    func execute(request: Request?) -> AnyPublisher<Response, Error>
}
