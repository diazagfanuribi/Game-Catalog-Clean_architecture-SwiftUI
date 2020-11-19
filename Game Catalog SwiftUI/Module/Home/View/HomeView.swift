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
    
    List{
        
        Group{
            ZStack {
              if presenter.loadingStateDeveloperRow {
                HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 0) {
                    Spacer()
                    ActivityIndicator()
                    Spacer()
                }
              } else {
                VStack(alignment: .leading, spacing: 0){
                    Text("Game Developer")
                        .font(.title)
                        .fontWeight(.bold)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack{
                            ForEach(
                              self.presenter.developer,
                              id: \.id
                            ) { category in
                                CategoryRow(category: category)
                            }
                        }
                    }
                }

                
              }
            }
        }
        Group{
            ZStack{
                if presenter.loadingStateGameColumn {
                  HStack {
                    Spacer()
                    ActivityIndicator()
                    Spacer()
                  }
                } else if presenter.errorMessage == "" {
                    VStack(alignment: .leading, spacing: 16){
                        Text("Top Rating")
                            .font(.title)
                            .fontWeight(.bold)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            ForEach(
                              self.presenter.game,
                              id: \.id
                            ) { game in
                                ZStack{
                                    self.presenter.linkBuilder(for: game){
                                        NewReleasedColumn(game: game)
                                    }
                                }
                              
                            }
                        
                        }
                    }
                } else{
                    HStack {
                        Spacer()
                        Text("Error : \(self.presenter.errorMessage)")
                        Spacer()
                    }
                }
            
            }
            
        }
        
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
