//
//  FavoriteView.swift
//  games
//
//  Created by Eric Theo on 22/12/23.
//

import SwiftUI
import Core
import Favorite
import Home
import Detail

struct FavoriteView: View {
  @StateObject var presenter: GetListPresenter<
    Any,
    FavoriteGameModel,
    Interactor<Any,
    [FavoriteGameModel],
    GetFavoriteGameRepository<GetFavoriteLocaleDataSource>>>
  var body: some View {
    NavigationView {
      ZStack {
        Color.black.opacity(0.9).ignoresSafeArea()
        if presenter.isLoading {
          VStack {
            ProgressView().progressViewStyle(CircularProgressViewStyle(tint: Color.white))
          }
        } else {
          if self.presenter.list.isEmpty {
            Text("Favorite is empty")
              .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
              .foregroundColor(.white)
          } else {
            ScrollView(.vertical, showsIndicators: false) {
              ForEach(
                self.presenter.list,
                id: \.id
              ) { game in
                CardView(game: GameModel(id: game.id,
                                         name: game.name,
                                         image: game.image,
                                         released: game.released,
                                         rating: game.rating), action: {
                  DetailView(presenter: DetailPresenter(detailUseCase: Injection.init().provideDetail()), id: game.id)
                })
              }
            }
          }
        }
      }.onAppear {
        self.presenter.getList(request: nil)
      }
    }
  }
}

#Preview {
  let favoriteUseCase: Interactor<
    Any,
    [FavoriteGameModel],
    GetFavoriteGameRepository<GetFavoriteLocaleDataSource>
  > = Injection.init().provideFavorite()
  let favoritePresenter = GetListPresenter(useCase: favoriteUseCase)
  return FavoriteView(presenter: favoritePresenter)
}
