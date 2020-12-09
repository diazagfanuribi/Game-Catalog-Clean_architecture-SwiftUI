//
//  FavoriteColumn.swift
//  Game Catalog SwiftUI
//
//  Created by DiazAgfa on 09/12/20.
//

import SwiftUI
import SDWebImageSwiftUI

struct FavoriteColumn: View {
    var game: GameDetailModel
    var body: some View {
        ZStack {
            HStack(alignment: .top, spacing: 16 ) {
                WebImage(url: URL(string: game.background))
                    .resizable()
                    .indicator(.activity)
                    .transition(.fade(duration: 0.5))
                    .frame(width: 150, height: 100, alignment: .center/*@END_MENU_TOKEN@*/)
                    .cornerRadius(2)
                    .clipped()
                    .scaledToFit()

                VStack(alignment: .leading, spacing: 0) {
                    Text(game.name)
                        .font(.title2)
                        .fontWeight(.semibold)
                    Text("Released : \(game.released)")
                    Text("Rating : \(game.ratingString)/5")
                    Spacer()
                }
                Spacer()
            }.frame(width: UIScreen.main.bounds.width, height: 100, alignment: .center/*@END_MENU_TOKEN@*/)

        }
    }
}

struct FavoriteColumn_Previews: PreviewProvider {
    static var previews: some View {
        let detail =
            GameDetailModel(id: 1,
                         name: "GTA V",
                         rating: 4.0,
                         released: "22-12-2020",
                         background: "https://media.rawg.io/media/screenshots/47d/47d74c9b88068a72ce3f5c492b954480.jpg",
                         description: "<p>From Frédérick Raynal, the creator of Alone in the Dark® .",
                         backgroundAdditional: "https://media.rawg.io/media/screenshots/47d/47d74c9b88068a72ce3f5c492b954480.jpg", website: "www", favorite: false)
            FavoriteColumn(game: detail)
    }
}
