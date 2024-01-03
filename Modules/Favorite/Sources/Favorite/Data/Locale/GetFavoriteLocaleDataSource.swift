//
//  File.swift
//  
//
//  Created by Eric Theo on 03/01/24.
//

import Foundation
import Combine
import Core
import CoreData

public class GetFavoriteLocaleDataSource:NSObject, LocaleDataSource {
  public typealias Request = Any
  public typealias Response = FavoriteGameModel
  lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "FavoriteGame")
    container.loadPersistentStores { _, error in
      guard error == nil else {
        fatalError("Unresolved error \(error!)")
      }
    }
    container.viewContext.automaticallyMergesChangesFromParent = false
    container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    container.viewContext.shouldDeleteInaccessibleFaults = true
    container.viewContext.undoManager = nil
    return container
  }()
  private func newTaskContext() -> NSManagedObjectContext {
    let taskContext = persistentContainer.newBackgroundContext()
    taskContext.undoManager = nil
    taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    return taskContext
  }
  public func list(request: Request?) -> AnyPublisher<[FavoriteGameModel], Error> {
    return Future<[FavoriteGameModel], Error> { completion in
      let taskContext = self.newTaskContext()
      taskContext.perform {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Game")
        do {
          let results = try taskContext.fetch(fetchRequest)
          var games: [FavoriteGameModel] = []
          for result in results {
            let game = FavoriteGameModel(id: result.value(forKeyPath: "id") as? String ?? "",
                                 name: result.value(forKeyPath: "name") as? String ?? "",
                                 image: result.value(forKeyPath: "image") as? String ?? "",
                                 released: result.value(forKeyPath: "released") as? String ?? "",
                                 rating: result.value(forKeyPath: "rating") as? Double ?? 0)
            games.append(game)
          }
          completion(.success(games))
        } catch let error as NSError {
          completion(.failure(error))
        }
      }
    }.eraseToAnyPublisher()
  }
  public func add(entities: [FavoriteGameModel]) -> AnyPublisher<Bool, Error> {
    fatalError("Unresolved error")
  }
  
  public func get(id: String) -> AnyPublisher<FavoriteGameModel, Error> {
    fatalError("Unresolved error")
  }
  
  public func update(id: Int, entity: FavoriteGameModel) -> AnyPublisher<Bool, Error> {
    fatalError("Unresolved error")
  }
}
