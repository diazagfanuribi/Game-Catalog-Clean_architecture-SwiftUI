//
//  DetailView.swift
//  Game Catalog SwiftUI
//
//  Created by DiazAgfa on 18/11/20.
//

import SwiftUI
import SDWebImageSwiftUI


struct DetailView: View {
    @ObservedObject var presenter : DetailPresenter
        
    var body: some View {
        ZStack{
            if presenter.loadingState == true{
                Spacer()
                ZStack{
                    ActivityIndicator()
                }
                Spacer()
            }else {
                DetailContentView(game : self.presenter.gameDetail)
            }
            

        }
        .onAppear{
            self.presenter.getDetail()
        }
        
        
        
    }
}

