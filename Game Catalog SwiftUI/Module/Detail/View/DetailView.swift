//
//  DetailView.swift
//  Game Catalog SwiftUI
//
//  Created by DiazAgfa on 18/11/20.
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailView: View {
    @ObservedObject var presenter: DetailPresenter

    var body: some View {
        ZStack {
            if presenter.loadingState == true {
                Spacer()
                ZStack {
                    ActivityIndicator()
                }
                Spacer()
            } else {
                List {
                    ZStack {
                        Rectangle().fill(/*@START_MENU_TOKEN@*/Color.blue/*@END_MENU_TOKEN@*/.opacity(0.3))
                        WebImage(url: URL(string: self.presenter.gameDetail.background))
                            .resizable()
                    }.aspectRatio(16/9, contentMode: .fit)
                    HStack {
                        Text("Description")
                            .font(.title2)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        Spacer()
                        if self.presenter.gameDetail.favorite {
                            Image(systemName: "heart.fill")
                              .font(.system(size: 18))
                              .foregroundColor(.pink)
                                .padding(10)
                                .onTapGesture { self.presenter.updateFavoriteMeal() }
                        } else {
                            Image(systemName: "heart")
                              .font(.system(size: 18))
                              .foregroundColor(.pink)
                                .padding(10)
                                .onTapGesture { self.presenter.updateFavoriteMeal() }
                        }

                    }

                    Text(self.presenter.gameDetail.description)
                        .multilineTextAlignment(.leading)
                }
            }

        }
        .navigationTitle(self.presenter.gameDetail.name)
        .onAppear {
            self.presenter.getDetail()
        }

    }
}
