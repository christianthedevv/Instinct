//
//  WinnerView.swift
//  Instinct
//
//  Created by Christian Rodriguez on 10/23/23.
//

import SwiftUI

struct WinnerView: View {
    @EnvironmentObject var gameVm : GameViewModel

    var body: some View {
        ZStack{
            VStack(spacing: 75){
                VStack(spacing:0){
//                        Text("CONGRATULATIONS").foregroundStyle(.black).font(.custom("Monda-Bold", size: 60))
                        Text("YOU WIN!").foregroundStyle(.green).font(.custom("Monda-Bold", size: 58))
                }
                HStack(spacing:35){
                    Button {
                        let impactMed = UIImpactFeedbackGenerator(style: .soft)
                            impactMed.impactOccurred()
                         withAnimation{
                            gameVm.gameState = .menu
                        }
                    }label: {
                        RoundedRectangle(cornerRadius: 20)
                                .stroke(.black, lineWidth: 3)
                                .overlay {
                                    Text("MENU").font(.custom("Monda-Regular", size: 25)).foregroundStyle(.teal)
                                }.frame(width: 150, height: 65)
                    }
                    Button {
                        let impactMed = UIImpactFeedbackGenerator(style: .soft)
                            impactMed.impactOccurred()
                        withAnimation{
                           gameVm.gameState = .start
                       }
                    }label: {
                        RoundedRectangle(cornerRadius: 20)
                                .stroke(.black, lineWidth: 3)
                                .overlay {
                                    Text("PLAY AGAIN").font(.custom("Monda-Regular", size: 20)).foregroundStyle(.teal)
                                }.frame(width: 150, height: 65)
                    }
                }
            }
        }
    }
}

#Preview {
    LoserView()
}
