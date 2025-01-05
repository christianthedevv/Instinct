//
//  LoserView.swift
//  Instinct
//
//  Created by Christian Rodriguez on 10/23/23.
//

import SwiftUI

struct LoserView: View {
    @AppStorage(PlayerConfigKeys.saturation) private var saturation: Double = 1.0
    @AppStorage(PlayerConfigKeys.soundEffects) private var soundEffects: Bool = true
    @AppStorage(PlayerConfigKeys.level) private var level: Int = 3
    @AppStorage(PlayerConfigKeys.haptics) private var haptics: Bool = true
    
    @EnvironmentObject var gameVm : GameViewModel

    var body: some View {
        ZStack{
            VStack(spacing: 75){
               

                VStack(spacing:0){
                        Text("GAME OVER").foregroundStyle(.black).font(.custom("Tiny5-Regular", size: 60))
                        Text("YOU LOSE").foregroundStyle(.red).font(.custom("Tiny5-Regular", size: 45))
                        .shadow(color: .black, radius:0.2, x: -2, y: -2)

                }
                VStack(spacing:35){
                    Button {
                        if haptics{
                            let impactMed = UIImpactFeedbackGenerator(style: .soft)
                                impactMed.impactOccurred()
                        }
                        withAnimation{
                           gameVm.gameState = .start
                       }
                    }label: {
                        Text("PLAY AGAIN")
                            .font(.custom("Tiny5-Regular", size: 35))
                            .foregroundStyle(.black)
                            .shadow(color: .gray, radius:0.2, x: -1, y: -1)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 3)
                            .background(RoundedRectangle(cornerRadius: 10).stroke( .black, lineWidth: 2))


                    }
                    Button {
                        if haptics{
                            let impactMed = UIImpactFeedbackGenerator(style: .soft)
                                impactMed.impactOccurred()
                        }
                         withAnimation{
                            gameVm.gameState = .menu
                        }
                    }label: {
                        Text("MENU")
                            .font(.custom("Tiny5-Regular", size: 25))
                            .foregroundStyle(.black)
                            .shadow(color: .gray, radius:0.2, x: -1, y: -1)


                    }
                    
                }
            }
        }
    }
}

#Preview {
    LoserView()
}
