//
//  HomeView.swift
//  Game Catalog SwiftUI
//
//  Created by DiazAgfa on 10/11/20.
//

import SwiftUI

struct HomeView: View {
  @ObservedObject var presenter: HomePresenter
  var body: some View {
    ScrollView {
        Group {
            VStack(alignment: .leading, spacing: 0) {
                Text("Game Developer")
                    .font(.title)
                    .fontWeight(.bold)
            ZStack {
              if presenter.loadingStateDeveloperRow {
                VStack {
                    HStack(alignment: .center, spacing: 0) {
                        Spacer()
                        ActivityIndicator()
                        Spacer()
                    }
                    ShimmeringCardView()
                }

              } else {
                VStack(alignment: .leading, spacing: 0) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(
                              self.presenter.developer,
                              id: \.id
                            ) { developer in
                                ZStack {
                                    self.presenter.linkDeveloperBuilder(for: developer) {
                                    CategoryRow(developer: developer)
                                    }
                                }
                            }
                        }
                    }
                }

              }
            }
            }
        }
        .padding(.leading, 20)
        Group {
            VStack(alignment: .leading, spacing: 0) {
                Text("Top Rating")
                    .font(.title)
                    .fontWeight(.bold)
            ZStack {
                if presenter.loadingStateGameColumn {
                    VStack {
                        HStack {
                          Spacer()
                          ActivityIndicator()
                          Spacer()
                        }
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
                                        NewReleasedColumn(game: game)
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
        }.padding(.leading, 20)

        Spacer()
    }.navigationBarTitle(
        Text("Game RAWG"),
          displayMode: .automatic
      )
    .onAppear {
        if self.presenter.developer.count == 0 {
        self.presenter.getCategories()
        }
        self.presenter.getGames()

    }
  }

}
