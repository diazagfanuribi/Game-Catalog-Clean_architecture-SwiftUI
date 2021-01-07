//
//  ShimmeringListView.swift
//  Game Catalog SwiftUI
//
//  Created by DiazAgfa on 10/12/20.
//

import SwiftUI

struct ShimmeringListView: View {
    private struct Constants {
        static let duration: Double = 0.9
        static let minOpacity: Double = 0.3
        static let maxOpacity: Double = 0.8
        static let cornerRadius: CGFloat = 4.0
    }
    @State private var opacity: Double = Constants.minOpacity
    public init() {}
    public var body: some View {
        RoundedRectangle(cornerRadius: Constants.cornerRadius)
            .fill(Color.gray)
            .opacity(opacity)
            .transition(.opacity)
            .frame(width: UIScreen.main.bounds.width-20, height: 100, alignment: .center)
            .padding(.leading, 20)
            .padding(.trailing, 20)
            .onAppear {
                let baseAnimation = Animation.easeInOut(duration: Constants.duration)
                let repeated = baseAnimation.repeatForever(autoreverses: true)
                withAnimation(repeated) {
                    self.opacity = Constants.maxOpacity
                }
        }
    }
}

struct ShimmeringListView_Previews: PreviewProvider {
    static var previews: some View {
        ShimmeringListView()
    }
}
