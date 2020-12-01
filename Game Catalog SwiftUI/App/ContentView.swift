//
//  ContentView.swift
//  Game Catalog SwiftUI
//
//  Created by DiazAgfa on 10/11/20.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var homePresenter: HomePresenter
    var body: some View {
        TabView{
            NavigationView {
              HomeView(presenter: homePresenter)
            }.tabItem {
                TabItem(imageName: "house", title: "Home")
            }
            NavigationView{
                SearchView()
            }.tabItem {
                TabItem(imageName: "magnifyingglass", title: "Search")
            }
            NavigationView{
                FavoriteView()
            }.tabItem {
                TabItem(imageName: "star", title: "Favorite")
            }
            NavigationView{
                AuthorView()
            }.tabItem {
                TabItem(imageName: "person", title: "Author")
            }
            
        }

    }
}

