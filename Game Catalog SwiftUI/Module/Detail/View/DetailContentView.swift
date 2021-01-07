//
//  DetailContentView.swift
//  Game Catalog SwiftUI
//
//  Created by DiazAgfa on 19/11/20.
//

import SwiftUI
import SDWebImageSwiftUI
import Game

struct DetailContentView: View {
    var game: GameDetailModel
    var body: some View {
        List {
            ZStack {
                Rectangle().fill(/*@START_MENU_TOKEN@*/Color.blue/*@END_MENU_TOKEN@*/.opacity(0.3))
                WebImage(url: URL(string: game.background))
                    .resizable()
            }.aspectRatio(16/9, contentMode: .fit)
            HStack {
                Text("Description")
                    .font(.title2)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                Spacer()
                Image(systemName: "heart")
                  .font(.system(size: 18))
                  .foregroundColor(.pink)
                    .padding(10)
            }

            Text(game.description)
                .multilineTextAlignment(.leading)

        }
        .navigationTitle(game.name)
    }
}
