//
//  ContentView.swift
//  games
//
//  Created by Eric Theo on 27/11/23.
//

import SwiftUI
import Home
import Core
import Detail

struct HomeView: View {
  @ObservedObject var presenter: GetListPresenter<
    Any,
    GameModel,
      Interactor<Any, [GameModel], GetGameRepository<GetGameRemoteData>>>
  var body: some View {
    NavigationView {
      ZStack {
        Color.black.opacity(0.9).ignoresSafeArea()
        if presenter.isLoading {
          VStack {
            ProgressView().progressViewStyle(CircularProgressViewStyle(tint: Color.white))
          }
        } else {
          ScrollView(.vertical, showsIndicators: false) {
            ForEach(
              self.presenter.list,
              id: \.id
            ) { game in
//              self.presenter.linkBuilder(id: game.id) {
              CardView(game: game, action: {
                DetailView(presenter: DetailPresenter(detailUseCase: Injection.init().provideDetail()), id: game.id)
              })
//              }
            }
          }
        }
      }.onAppear {
        self.presenter.getList(request: nil)
      }
    }
  }
}

struct CardView<Destination: View>: View {
  var game: GameModel
  var action: (() -> Destination)
  init(game: GameModel, action: @escaping () -> Destination) {
    self.game = game
    self.action = action
  }
  var body: some View {
    NavigationLink(destination: self.action) {
      HStack(alignment: .top) {
        VStack(alignment: .center) {
          AsyncImage(url: URL(string: game.image)) { image in
            image.resizable()
          } placeholder: {
            ProgressView().progressViewStyle(CircularProgressViewStyle(tint: Color.white))
          }
          .frame(
            maxWidth: .infinity, maxHeight: 200)
          .foregroundStyle(.black)
          .cornerRadius(8)
          .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/, radius: 8)
          Spacer()
          Text(game.name).font(.title3).foregroundColor(.white).bold()
          HStack(alignment: .center) {
            HStack {
              Image(systemName: "star.fill")
                .foregroundColor(.yellow)
              Text(String(game.rating)).foregroundColor(.white)
            }
            Spacer()
            Text(game.released).font(.footnote).foregroundColor(.white)
          }
        }.padding()
      }
      .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
      .background(.black.opacity(0.9))
      .cornerRadius(8)
    .padding(.horizontal, 8)
    }
  }
}

#Preview {
  let homeUseCase: Interactor<
    Any,
    [GameModel],
    GetGameRepository<GetGameRemoteData>
  > = Injection.init().provideHome()
  let homePresenter = GetListPresenter(useCase: homeUseCase)
  return HomeView(presenter: homePresenter)
}
