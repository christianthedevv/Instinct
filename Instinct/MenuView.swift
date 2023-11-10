//
//  MenuView.swift
//  Instinct
//
//  Created by Christian Rodriguez on 10/23/23.
//

import SwiftUI

struct MenuView: View {
    @EnvironmentObject var gameVm : GameViewModel
    @State var settings: Bool = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 50) {
//                Spacer()
                Text("INSTINCT").font(.custom("Monda-Regular", size: 45)).padding(.vertical, 100)
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
                    Spacer()
                    Button{
                        // settigns
                        settings = true
                    }label: {
                        HStack{
                            Image(systemName: "gear")
                            Text("Game Settings")
                        }.font(.custom("Monda-Regular", size: 20)).foregroundStyle(.black)
                    }
                }.padding(.bottom, 150)
            }
        }.sheet(isPresented: $settings , content: {
            VStack{
                // preference settings
                Form(content: {
                    Menu {
                        Text("Neon")
                        Text("Pastel")
                        Text("Black & White")
                    } label: {
                        Text("Color pallete")
                    }
                    Toggle(isOn: $gameVm.haptics, label: {
                        Text("Haptics")
                    })
                    Toggle(isOn: $gameVm.soundEffects, label: {
                        Text("Sound Effects")
                    })
                })
                // gameplay settings
                Form(content: {
                    Toggle(isOn: $gameVm.timerMode, label: {
                        Text("Timer Mode")
                    })
                })
            }.font(.custom("Monda-Regular", size: 20)).foregroundStyle(.black)
        })
    }
}

#Preview {
    MenuView().environmentObject(GameViewModel())
}
