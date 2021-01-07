//
//  CategoryRow.swift
//  Game Catalog SwiftUI
//
//  Created by DiazAgfa on 10/11/20.
//
import SwiftUI
import SDWebImageSwiftUI
import Game

struct CategoryRow: View {
  var developer: DeveloperModel
  var body: some View {
    ZStack(alignment: .bottomLeading) {
        imageCategory
        content
    }.frame(height: UIScreen.main.bounds.height/3)
    .background(Color.black.opacity(0.05))
    .padding(.leading, 20)

  }

}

extension CategoryRow {

  var imageCategory: some View {
    WebImage(url: URL(string: developer.imageUrl))
      .resizable()
      .indicator(.activity)
      .transition(.fade(duration: 0.5))
      .frame(width: UIScreen.main.bounds.width-32)
        .cornerRadius(10)
        .clipped()
        .scaledToFit()

  }

  var content: some View {
    VStack(alignment: .leading, spacing: 10) {
      Text(developer.name)
        .font(.title2)
        .bold()
        .lineLimit(nil)
        .foregroundColor(.white)
        .padding(.leading)
    }.background(Color.gray.opacity(0.5))

  }
    var blurView : some View {
        BlurView()
    }

}


extension Color {

  static var random: Color {
    return Color(
      red: .random(in: 0...1),
      green: .random(in: 0...1),
      blue: .random(in: 0...1)
    )
  }

}
