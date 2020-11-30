//
//  Developer.swift
//  Game Catalog SwiftUI
//
//  Created by DiazAgfa on 30/11/20.
//

import SwiftUI

struct DeveloperView: View {
    var title : String
    var body: some View {
        Text("This feature is still not available yet")
            .navigationTitle(title)
    }
}

struct DeveloperView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DeveloperView(title: "Rockstar")
        }
    }
}
