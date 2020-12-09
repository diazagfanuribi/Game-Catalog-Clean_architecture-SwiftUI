//
//  AuthorView.swift
//  Game Catalog SwiftUI
//
//  Created by DiazAgfa on 20/11/20.
//

import SwiftUI
import SDWebImageSwiftUI

struct AuthorView: View {
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                    HStack {
                    Spacer()
                    Image("Author")
                        .resizable()
                        .frame(width: 150, height: 150, alignment: .center/*@END_MENU_TOKEN@*/)
                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                        .aspectRatio(16/9, contentMode: .fit)
                    Spacer()
                    }
                Text("Diaz Agfa Nuribi")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Text("diazagfanuribi@gmail.com")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Spacer()
            }

        }
        .frame(width: 400, height: 500)
        .background(LinearGradient(gradient: Gradient(colors: [Color("ColorDarkBlue"),
                                                               Color("ColorLightBlue")]),
                                                               startPoint: .top,
                                                               endPoint: .bottom))
        .cornerRadius(10)
        .navigationBarTitle(
            Text("Author"),
            displayMode: .large
          )

    }
}

struct AuthorView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AuthorView()
        }
    }
}
