//
//  ContentView.swift
//  Game Catalog SwiftUI
//
//  Created by DiazAgfa on 10/11/20.
//

import SwiftUI
import Core
import Game

struct ContentView: View {
    @EnvironmentObject var homePresenter: GetHomePresenter<
        Interactor<String,[DeveloperModel],GetDeveloperRepository<GetDeveloperLocaleDataSource,GetDeveloperRemoteDataSource,DeveloperTransformer>>,
        Interactor<String,[GameModel], GetGameRepository<GetGamesLocaleDataSource,GetGamesRemoteDataSource,GamesTransformer>>
        >
    @EnvironmentObject var favoritePresenter : GetListPresenter<String, GameDetailModel, Interactor<String, [GameDetailModel], GetFavoriteRepository<GetFavoriteLocaleDataSource, FavoriteTransformer>>>
    var body: some View {
        TabView {
            NavigationView {
              HomeView(presenter: homePresenter)
            }.tabItem {
                TabItem(imageName: "house", title: "Home")
            }
            NavigationView {
                SearchView()
            }.tabItem {
                TabItem(imageName: "magnifyingglass", title: "Search")
            }
            NavigationView {
                FavoriteView(presenter: favoritePresenter)
            }.tabItem {
                TabItem(imageName: "star", title: "Favorite")
            }
            NavigationView {
                AuthorView()
            }.tabItem {
                TabItem(imageName: "person", title: "Author")
            }

        }

    }
}
