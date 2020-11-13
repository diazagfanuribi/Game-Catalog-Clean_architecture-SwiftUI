//
//  NewReleasedColumn.swift
//  Game Catalog SwiftUI
//
//  Created by DiazAgfa on 12/11/20.
//

import SwiftUI
import SDWebImageSwiftUI
struct NewReleasedColumn: View {
    var game : GameModel
    var body: some View {
        ZStack{
            HStack(alignment:.top ,spacing: 16 ){
                WebImage(url: URL(string: game.background))
                    .resizable()
                    .indicator(.activity)
                    .transition(.fade(duration: 0.5))
                    .frame(width: 150, height: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .cornerRadius(2)
                    .clipped()
                    .scaledToFit()
            
                VStack(alignment:.leading , spacing:0){
                    Text(game.name)
                        .font(.title2)
                        .fontWeight(.semibold)
                    Text("Released : \(game.released)")
                    Text("Rating : \(game.rating)/5")
                    Spacer()
                }
                Spacer()
            }.frame(width: UIScreen.main.bounds.width, height: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            
        }
    }
}

//struct NewReleasedColumn_Previews: PreviewProvider {
//    static var previews: some View {
//        NewReleasedColumn(game: GameModel(id: 100, name: "Avenger", rating: 4, released: "2020-10-1", background: "https://media.rawg.io/media/games/2ad/2ad87a4a69b1104f02435c14c5196095.jpg"))
//    }
//}
