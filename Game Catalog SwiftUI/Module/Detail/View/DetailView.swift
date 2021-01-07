//
//  DetailView.swift
//  Game Catalog SwiftUI
//
//  Created by DiazAgfa on 18/11/20.
//

import SwiftUI
import SDWebImageSwiftUI
import Core
import Game
import Foundation

struct DetailView: View {
    @ObservedObject var presenter : GetDetailPresenter
    <Interactor
    <String,GameDetailModel,UpdateFavoriteRepository<GetFavoriteLocaleDataSource,GameDetailTransformer>>,
    Interactor<String, GameDetailModel, GetGameDetailRepository<
                GetGameDetailLocaleDataSource,GetGameDetailRemoteDataSource,GameDetailTransformer>>>
    
    var body: some View {
        ZStack {
            if presenter.isLoading == true {
                Spacer()
                ZStack {
                    ActivityIndicator()
                }
                Spacer()
            } else {
                List {
                    ZStack {
                        Rectangle().fill(/*@START_MENU_TOKEN@*/Color.blue/*@END_MENU_TOKEN@*/.opacity(0.3))
                        WebImage(url: URL(string: self.presenter.game.background))
                            .resizable()
                    }.aspectRatio(16/9, contentMode: .fit)
                    HStack {
                        Text("Description")
                            .font(.title2)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        Spacer()
                        if self.presenter.game.favorite {
                            Image(systemName: "heart.fill")
                              .font(.system(size: 18))
                              .foregroundColor(.pink)
                                .padding(10)
                                .onTapGesture { self.presenter.updateFavorite(request: String(self.presenter.game.id))}
                        } else {
                            Image(systemName: "heart")
                              .font(.system(size: 18))
                              .foregroundColor(.pink)
                                .padding(10)
                                .onTapGesture { self.presenter.updateFavorite(request: String(self.presenter.game.id)) }
                        }

                    }

                    Text(self.presenter.game.description)
                        .multilineTextAlignment(.leading)
                }
            }
        }
        .navigationTitle(self.presenter.game.name)
        .onAppear {
            self.presenter.getGame(request: "")
            
        }
    }
}
