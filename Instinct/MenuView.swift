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
    @Binding var launched: Bool

    var body: some View {
        ZStack {
            if launched {
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
                                Text("COLORS").font(.custom("PixelSans-Regular", size: 25)).foregroundStyle(.teal)
                            }.frame(width: 150, height: 65)
                    }
                    Button{
                        // settigns
                        settings = true
                    }label: {
                        HStack{
                            Image(systemName: "gear")
                            Text("Game Settings")
                        }.font(.custom("Monda-Regular", size: 20)).foregroundStyle(.black)
                    }
                }
                .transition(.move(edge: .bottom))
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
                    Toggle(isOn: $gameVm.timerMode, label: {
                        Text("Timer Mode")
                    })
                })
            }.font(.custom("Monda-Regular", size: 20)).foregroundStyle(.black)
        })
    }
}

#Preview {
    MenuView(launched: .constant(true)).environmentObject(GameViewModel())
}
