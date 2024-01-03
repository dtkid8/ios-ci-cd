//
//  File.swift
//  
//
//  Created by Eric Theo on 03/01/24.
//

import Foundation
import Core
import Combine
import CoreData

public class GetGameDetailLocaleDataSource: NSObject, LocaleDataSource{
  public typealias Request = Any
  public typealias Response = GameDetailModel
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
  public func list(request: Request?) -> AnyPublisher<[GameDetailModel], Error> {
    fatalError()
  }
  public func add(entities: [GameDetailModel]) -> AnyPublisher<Bool, Error> {
    fatalError()
  }
  public func get(id: String) -> AnyPublisher<GameDetailModel, Error> {
    fatalError()
  }
  public func update(id: Int, entity: GameDetailModel) -> AnyPublisher<Bool, Error> {
    fatalError()
  }
  func addFavoriteGame(game: GameDetailModel) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      let taskContext = self.newTaskContext()
      taskContext.performAndWait {
        if let entity = NSEntityDescription.entity(forEntityName: "Game", in: taskContext) {
          let addGame = NSManagedObject(entity: entity, insertInto: taskContext)
          addGame.setValue(game.id, forKeyPath: "id")
          addGame.setValue(game.name, forKeyPath: "name")
          addGame.setValue(game.backgroundImage, forKeyPath: "image")
          addGame.setValue(game.released, forKeyPath: "released")
          addGame.setValue(game.rating, forKeyPath: "rating")
          do {
            try taskContext.save()
            completion(.success(true))
          } catch let error as NSError {
            completion(.failure(error))
          }
        }
      }
    }.eraseToAnyPublisher()
  }
  func deleteFavoriteGame(id: String) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      let taskContext = self.newTaskContext()
      taskContext.perform {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Game")
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "id == \(id)")
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        batchDeleteRequest.resultType = .resultTypeCount
        if let batchDeleteResult = try? taskContext.execute(batchDeleteRequest) as? NSBatchDeleteResult {
          if batchDeleteResult.result != nil {
            completion(.success(true))
          } else {
            completion(.success(false))
          }
        }
      }
    }.eraseToAnyPublisher()
  }
  func checkFavoriteGame(id: String) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      let taskContext = self.newTaskContext()
      taskContext.perform {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Game")
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "id == \(id)")
        if let fetchResult = try? taskContext.fetch(fetchRequest) {
          if fetchResult.count > 0 {
            completion(.success(true))
          } else {
            completion(.success(false))
          }
        }
      }
    }.eraseToAnyPublisher()
  }
}
