//
//  HomeView.swift
//  Game Catalog SwiftUI
//
//  Created by DiazAgfa on 10/11/20.
//

import SwiftUI
import Core
import Game

struct HomeView: View {
    @ObservedObject var presenter: GetHomePresenter<
        Interactor<String,[DeveloperModel],GetDeveloperRepository<GetDeveloperLocaleDataSource,GetDeveloperRemoteDataSource,DeveloperTransformer>>,
        Interactor<String,[GameModel], GetGameRepository<GetGamesLocaleDataSource,GetGamesRemoteDataSource,GamesTransformer>>
        >
    var body: some View {
        ScrollView {
            Group {
                VStack(alignment: .leading, spacing: 0) {
                    Text("Game Developer")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.leading, 20)

                    ZStack {
                        if presenter.loadingStateDeveloperRow {
                            VStack {
                                HStack(alignment: .center, spacing: 0) {
                                    Spacer()
                                    ActivityIndicator()
                                    Spacer()
                                }
                                ShimmeringCardView().padding(.leading, 20)
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
                                                self.linkDeveloperBuilder(for: developer) {
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
            Group {
                VStack(alignment: .leading, spacing: 0) {
                    Text("Top Rating")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.leading, 20)

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
                                            self.linkBuilder(for: game) {
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
            }
            Spacer()
        }
        .navigationBarTitle(
            Text("Game RAWG"),
            displayMode: .automatic
        )
        .onAppear {
            if self.presenter.developer.count == 0 {
                self.presenter.getDeveloper(request: "")
            }
            self.presenter.getGame(request: "")
        }
    }
    
    
    func linkBuilder<Content: View>(
      for game: GameModel,
      @ViewBuilder content: () -> Content
    ) -> some View {
      NavigationLink(
      destination: HomeRouter().makeDetailView(for: game)) { content() }
    }

      func linkDeveloperBuilder<Content: View>(
        for developer: DeveloperModel,
        @ViewBuilder content: () -> Content
      ) -> some View {
        NavigationLink(
          destination: HomeRouter().makeDeveloperListView(input: developer)) { content() }
      }
}
