//
//  FavoriteView.swift
//  Game Catalog SwiftUI
//
//  Created by DiazAgfa on 20/11/20.
//

import SwiftUI

struct FavoriteView: View {
    @ObservedObject var presenter: FavoritePresenter
    var body: some View {

        ScrollView {
            Group {
                ZStack {
                    if presenter.loadingState {
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
                                  self.presenter.game,
                                  id: \.id
                                ) { game in
                                    ZStack {
                                        self.presenter.linkBuilder(for: game) {
                                            FavoriteColumn(game: game)
                                        }
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
            self.presenter.getGames()

        }
    }
}
