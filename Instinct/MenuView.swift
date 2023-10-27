//
//  MenuView.swift
//  Instinct
//
//  Created by Christian Rodriguez on 10/23/23.
//

import SwiftUI

struct MenuView: View {
    @EnvironmentObject var gameVm : GameViewModel

    var body: some View {
        NavigationStack {
            VStack(spacing:150) {
//                Spacer()
                Text("INSTINCT").font(.custom("Monda-Regular", size: 45)).padding(.bottom, 150)
                VStack(spacing:35){
                    Button {
                        let impactMed = UIImpactFeedbackGenerator(style: .soft)
                            impactMed.impactOccurred()
                       withAnimation {
                            gameVm.gameMode = .classic
                            gameVm.gameState = .start
                        }
                    }label: {
                        RoundedRectangle(cornerRadius: 20)
                                .stroke(.black, lineWidth: 3)
                                .overlay {
                                    Text("NUMBERS").font(.custom("Monda-Regular", size: 25)).foregroundStyle(.teal)
                                }.frame(width: 150, height: 65)
                    }
                    Button {
                        let impactMed = UIImpactFeedbackGenerator(style: .soft)
                            impactMed.impactOccurred()
                        withAnimation {
                            gameVm.gameMode = .arcade
                            gameVm.gameState = .start
                        }
                    }label: {
                        RoundedRectangle(cornerRadius: 20)
                                .stroke(.black, lineWidth: 3)
                                .overlay {
                                    Text("COLORS").font(.custom("Monda-Regular", size: 25)).foregroundStyle(.teal)
                                }.frame(width: 150, height: 65)
                    }
                }.padding(.bottom, 150)
            }
        }
    }
}

#Preview {
    MenuView()
}
