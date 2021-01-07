//
//  Developer.swift
//  Game Catalog SwiftUI
//
//  Created by DiazAgfa on 30/11/20.
//

import SwiftUI
import Core
import Game

struct DeveloperView: View {
    var developer: DeveloperModel
    @ObservedObject var presenter: GetListPresenter<String, GameModel,Interactor<String,[GameModel],GetGamesByDeveloperRepository<GetGameByDeveloperRemoteDataSource,GamesTransformer>>>
    var body: some View {
        ScrollView {
            Group {
                VStack(alignment: .leading, spacing: 0) {
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
                                        ZStack {
                                            self.linkBuilder(for: game) {
                                                NewReleasedColumn(game: game)
                                            }
                                        }
                                    }
                                }
                            }
                        } else {
                            VStack {
                                Spacer()
                                Text("Error : \(self.presenter.errorMessage)")
                                Spacer()

                            }
                        }
                    }
                }
            }
        }.navigationBarTitle(
            Text(developer.name),
            displayMode: .automatic
        )
        .onAppear {
            self.presenter.getList(request: String(developer.id))
        }
    }
    
    func linkBuilder<Content: View>(
      for game: GameModel,
      @ViewBuilder content: () -> Content
    ) -> some View {
      NavigationLink(
      destination: DeveloperRouter().makeDetailView(for: game)) { content() }
    }
}
