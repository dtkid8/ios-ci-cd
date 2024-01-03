//
//  ProfileView.swift
//  games
//
//  Created by Eric Theo on 20/12/23.
//

import SwiftUI

struct ProfileView: View {
  var body: some View {
      VStack {
        Image("EricThioko")
          .resizable()
          .aspectRatio(contentMode: .fill)
          .frame(
            maxWidth: 300,
            maxHeight: 300)
          .clipShape(Circle())
          .overlay(Circle().stroke(Color.white, lineWidth: 4))
        Text("Eric Thioko")
          .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
          .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
          .foregroundColor(.white)
          .padding()
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .background(Color.black.opacity(0.9))
  }
}

#Preview {
  ProfileView()
}
