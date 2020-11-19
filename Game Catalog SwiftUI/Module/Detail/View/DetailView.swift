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
        DetailContentView()
    }
}

