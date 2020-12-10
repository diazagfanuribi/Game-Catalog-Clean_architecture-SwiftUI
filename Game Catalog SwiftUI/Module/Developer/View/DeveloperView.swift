//
//  Developer.swift
//  Game Catalog SwiftUI
//
//  Created by DiazAgfa on 30/11/20.
//

import SwiftUI

struct DeveloperView: View {
    var title: String
    @ObservedObject var presenter: DeveloperPresenter
    var body: some View {
        ScrollView {
            Group {
                VStack(alignment: .leading, spacing: 0) {
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
            Text(title),
            displayMode: .automatic
        )
        .onAppear {
            self.presenter.getGamesByDeveloper()
        }
    }
}
