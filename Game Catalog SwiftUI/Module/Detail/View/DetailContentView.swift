//
//  DetailContentView.swift
//  Game Catalog SwiftUI
//
//  Created by DiazAgfa on 19/11/20.
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailContentView: View {
    var body: some View {
        List{
            ZStack{
                Rectangle().fill(/*@START_MENU_TOKEN@*/Color.blue/*@END_MENU_TOKEN@*/.opacity(0.3))
                WebImage(url: URL(string: "https://media.rawg.io/media/games/2ad/2ad87a4a69b1104f02435c14c5196095.jpg"))
                    .resizable()
            }.aspectRatio(16/9,contentMode: .fit)
            Text("Description")
                .font(.title2)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            
            Text("A first person grappling hook exploration game.\nSoar through the ruins of a fallen world and discover the secrets of the ancients. Windlands has been developed primarily for Virtual Reality headsets, but is also a great experience for those without headsets.\nIt appeals to those who want to explore the breathtaking vistas at a relaxing pace, while the challenging routes attract gamers who like to master the skill of soaring through the towering environments at top speed.Gameplay Features\nDesigned and built for Virtual Reality First.\nGrappling Hooks Focused Movement.\nVariety of expansive levels that reward exploration.\nMultiple routes provide a range of optional challenges.\nOptional Skill based, Speed Runs and Time Trials with Leaderboards.\nGoal Driven Gameplay with Easy (Hook Anything), Normal and Hard Modes.\nCollectibles that reward exploration and completionism.\nCalm, Positive, Pressure-Free, Non-Violent, Zen like relaxing play.\nWARNING: Windlands is an intense (but awesome) experience in VR, it takes time to get your VR Legs, please take baby steps if you are sensitive to locomotion in VR play in very short sessions and perhaps try cages, sitting down and a controller if you are still effected, the second you feel a bit of nausea please stop and take a break")
                .multilineTextAlignment(.leading)
                
            
        }
        .navigationTitle("BloodShot")
    }
}

struct DetailContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            DetailContentView()
        }
        
    }
}
