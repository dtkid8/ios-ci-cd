//
//  File.swift
//  
//
//  Created by Eric Theo on 02/01/24.
//

import Foundation
import Foundation
 
public protocol Mapper {
    associatedtype Response
    associatedtype Entity
    associatedtype Domain
    
    func transformResponseToEntity(response: Response) -> Entity
    func transformEntityToDomain(entity: Entity) -> Domain
}

