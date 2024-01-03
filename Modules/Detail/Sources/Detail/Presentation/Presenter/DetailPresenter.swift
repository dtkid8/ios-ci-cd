//
//  File.swift
//  
//
//  Created by Eric Theo on 03/01/24.
//

import Foundation
import Combine

public class DetailPresenter: ObservableObject {
  private let detailUseCase: DetailUseCase
  @Published public var game: GameDetailModel = GameDetailModel(id: "",
                                                         slug: "",
                                                         name: "",
                                                         nameOriginal: "",
                                                         gameDescription: "",
                                                         released: "",
                                                         tba: false,
                                                         updated: "",
                                                         backgroundImage: "",
                                                         backgroundImageAdditional: "",
                                                         website: "",
                                                         rating: 0,
                                                         ratingTop: 0
  )
  @Published public var errorMessage: String = ""
  @Published public var loadingState: Bool = false
  @Published public var isFavorite: Bool = false
  private var cancellables: Set<AnyCancellable> = []
  public init(detailUseCase: DetailUseCase) {
    self.detailUseCase = detailUseCase
  }
  public func getGameDetail(id: String) {
    loadingState = true
    detailUseCase.getGameDetail(id: id)
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .finished:
          self.loadingState = false
        case .failure:
          self.loadingState = false
          self.errorMessage = String(describing: completion)
        }
      }, receiveValue: { game in
        self.game = game
        self.detailUseCase.checkFavoriteGame(id: id)
          .receive(on: RunLoop.main)
          .sink(receiveCompletion: { _ in
          }, receiveValue: { check in
            self.isFavorite = check
          })
          .store(in: &self.cancellables)
      })
      .store(in: &cancellables)
  }
  public func favorite() {
    self.detailUseCase.checkFavoriteGame(id: self.game.id)
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { _ in
      }, receiveValue: { check in
        if check {
          self.detailUseCase.deleteFavoriteGame(id: self.game.id)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { _ in
            }, receiveValue: { _ in
              self.isFavorite = false
            }).store(in: &self.cancellables)
        } else {
          self.detailUseCase.addFavoriteGame(
            game: self.game
          )
          .receive(on: RunLoop.main)
          .sink(receiveCompletion: { _ in
          }, receiveValue: { _ in
            self.isFavorite = true
          }).store(in: &self.cancellables)
        }
      })
      .store(in: &cancellables)
  }
}
