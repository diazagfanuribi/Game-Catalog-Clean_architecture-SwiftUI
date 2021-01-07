//
//  FavoriteView.swift
//  Game Catalog SwiftUI
//
//  Created by DiazAgfa on 20/11/20.
//

import SwiftUI
import Game
import Core

struct FavoriteView: View {
    @ObservedObject var presenter: GetListPresenter<String, GameDetailModel, Interactor<String, [GameDetailModel], GetFavoriteRepository<GetFavoriteLocaleDataSource, FavoriteTransformer>>>
    var body: some View {

        ScrollView {
            Group {
                ZStack {
                    if presenter.isLoading {
                        VStack {
                            HStack {
                              Spacer()
                              ActivityIndicator()
                              Spacer()
                            }
                            ShimmeringListView()
                            ShimmeringListView()
                            ShimmeringListView()
                            ShimmeringListView()

                        }
                    } else if presenter.errorMessage == "" {
                        VStack(alignment: .leading, spacing: 16) {
                            ScrollView(.horizontal, showsIndicators: false) {
                                ForEach(
                                  self.presenter.list,
                                  id: \.id
                                ) { game in
                                    self.linkBuilder(for: game){
                                        FavoriteColumn(game: game)
                                    }
                                    
                                }

                            }
                        }
                    } else {
                        HStack {
                            Spacer()
                            Text("Error : \(self.presenter.errorMessage)")
                            Spacer()
                        }
                    }

                }

            }
            .padding()

            Spacer()
        }.navigationBarTitle(
            Text("Favorite"),
              displayMode: .automatic
          )
        .onAppear {
            self.presenter.getList(request: nil)

        }
    }
    
    func linkBuilder<Content: View>(
      for game: GameDetailModel,
      @ViewBuilder content: () -> Content
    ) -> some View {
      NavigationLink(
      destination: FavoriteRouter().makeDetailView(for: game)) { content() }
    }
}
