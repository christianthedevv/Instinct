//
//  PlaygroundView.swift
//  Instinct
//
//  Created by Christian Rodriguez on 10/27/23.
//

import SwiftUI

struct PlaygroundView: View {
    @EnvironmentObject var gameVm : GameViewModel
//    var colors: [Color] = [.blue, .red, .green, .orange]
    @State var index: Int = 0
    
    @State var progress: CGFloat = 0
    var body: some View {
        VStack {
            HStack {
                SplashView(animationType: .topToBottom, color: Color(hue: gameVm.colorHues[Int(gameVm.color)], saturation: 1, brightness: 1))
                    .frame(width: 100, height: 100, alignment: .center)
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 4)
            }
            
            Button(action: {
                gameVm.gameStep = .randomizing
            }) {
                Text("Change Color")
            }
            .padding(.top, 200)
        }
        .padding(.all, 200)
        .background(Color(red: 38/255, green: 50/255, blue: 56/255))
  
    }
}

#Preview {
    PlaygroundView()
}
