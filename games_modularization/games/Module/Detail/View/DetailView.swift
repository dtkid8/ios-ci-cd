//
//  DetailView.swift
//  games
//
//  Created by Eric Theo on 12/12/23.
//

import SwiftUI
import Detail

struct DetailView: View {
  @ObservedObject var presenter: DetailPresenter
  var id: String
  var body: some View {
    ZStack {
      Color.black.opacity(0.9).ignoresSafeArea()
      if presenter.loadingState {
        VStack {
          ProgressView().progressViewStyle(CircularProgressViewStyle(tint: Color.white))
        }
      } else {
        ScrollView {
          VStack {
            AsyncImage(url: URL(string: presenter.game.backgroundImage)) { image in
              image.resizable()
            } placeholder: {
              ProgressView()
            }.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: 300)
            Text(presenter.game.nameOriginal)
              .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
              .bold()
              .foregroundColor(.white)
            Text(presenter.game.released).font(.footnote)
              .foregroundColor(.white)
            Group {
              HStack(alignment: .center) {
                HStack {
                  Label {
                    Text(String(presenter.game.rating))
                      .foregroundColor(.white)
                  } icon: {
                    Image(systemName: "star.fill")
                      .foregroundColor(.yellow)
                  }
                }
                Spacer()
                Label {
                  Text(String("Favorite"))
                    .foregroundColor(.white)
                } icon: {
                  Image(systemName: presenter.isFavorite ? "heart.fill" : "heart")
                    .foregroundColor(.yellow)
                }.onTapGesture {
                  self.presenter.favorite()
                }
              }
              Text("Description")
                .font(.headline)
                .frame(
                  maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,
                  alignment: .leading)
                .foregroundColor(.white)
              Text(presenter.game.getGameDescription())
                .font(.caption)
                .foregroundColor(.white)
            }
            .padding(EdgeInsets(top: 0, leading: 8, bottom: 8, trailing: 8))
            AsyncImage(url: URL(string: presenter.game.backgroundImageAdditional)) { image in
              image.resizable()
            } placeholder: {
              ProgressView()
            }.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: 300)
          }
        }
      }
    }.onAppear {
      self.presenter.getGameDetail(id: id)
    }
  }
}

#Preview {
  DetailView(presenter: DetailPresenter(detailUseCase: Injection.init().provideDetail()), id: "3498")
}
