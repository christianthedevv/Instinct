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
    @State var info: Bool = false

    @Binding var launched: Bool

    var body: some View {
        ZStack {
            if launched {
                VStack(spacing:20){
                    HStack{
                        Spacer()
                        Button{
                            info.toggle()
                        }label: {
                            Text("i").font(.custom("Tiny5-Regular", size: 40))
                                .foregroundStyle(.black).padding(.horizontal, 30)

                        }
                    }
                    Spacer()
                    Button {
                        let impactMed = UIImpactFeedbackGenerator(style: .soft)
                        impactMed.impactOccurred()
                        withAnimation {
                            gameVm.gameMode = .classic
                            gameVm.gameState = .start
                        }
                    }label: {
                        ZStack{
                            HStack(spacing: 0){
                                ForEach([0.0, 0.1, 0.16, 0.35, 0.6, 0.8], id:\.self){ color in
                                    Rectangle().foregroundStyle(Color(white: color).gradient)
                                }
                            }
//                            Spacer().background(.ultraThinMaterial)
                        }
                            .overlay {
                                Text("CLASSIC").font(.custom("Tiny5-Regular", size: 38))
                                    .foregroundStyle(.white.gradient
                                )

                                .shadow(color: .black, radius:0.2, x: -1, y: -1)
//                                .background(.ultraThinMaterial)
                            }
                            .frame(width: UIScreen.main.bounds.width * 0.5, height: UIScreen.main.bounds.width * 0.2)                            .padding(3)
                            .background {
                                HStack(spacing: 0){
                                    ForEach([0.0, 0.1, 0.16, 0.35, 0.6, 0.8], id:\.self){ color in
                                        Rectangle().foregroundStyle(Color(white: color).gradient)
                                    }
                                }
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .shadow(color: .black, radius:0.2, x: -1, y: -1)

                    }
//                    Button {
//                        let impactMed = UIImpactFeedbackGenerator(style: .soft)
//                        impactMed.impactOccurred()
//                        withAnimation {
//                            gameVm.gameMode = .classic
//                            gameVm.gameState = .start
//                        }
//                    }label: {
//                        ZStack{
//                            HStack(spacing: 0){
//                                ForEach([0.0, 0.1, 0.16, 0.35, 0.6, 0.8], id:\.self){ color in
//                                    Rectangle().foregroundStyle(Color(white: color).gradient)
//                                }
//                            }
////                            Spacer().background(.ultraThinMaterial)
//                        }
//                            .overlay {
//                                Text("CLASSIC").font(.custom("Tiny5-Regular", size: 38))
//                                    .foregroundStyle(.white.gradient
//                                )
//
//                                .shadow(color: .black, radius:0.2, x: -1, y: -1)
////                                .background(.ultraThinMaterial)
//                            }
//                            .frame(width: UIScreen.main.bounds.width * 0.5, height: UIScreen.main.bounds.width * 0.2)                            .padding(3)
//                            .background {
//                                HStack(spacing: 0){
//                                    ForEach([0.0, 0.1, 0.16, 0.35, 0.6, 0.8], id:\.self){ color in
//                                        Rectangle().foregroundStyle(Color(white: color).gradient)
//                                    }
//                                }
//                            }
//                            .clipShape(RoundedRectangle(cornerRadius: 12))
//                            .shadow(color: .black, radius:0.2, x: -1, y: -1)
//
//                    }
                    
                    Button {
                        let impactMed = UIImpactFeedbackGenerator(style: .soft)
                        impactMed.impactOccurred()
                        withAnimation {
                            gameVm.gameMode = .arcade
                            gameVm.gameState = .start
                        }
                    }label: {
                        ZStack{
                            HStack(spacing: 0){
                                ForEach([0.0, 0.1, 0.16, 0.35, 0.6, 0.8], id:\.self){ color in
                                    Rectangle().foregroundStyle(Color(hue: color , saturation: 1, brightness: 0.9).gradient)
                                }
                            }.clipShape(RoundedRectangle(cornerRadius: 12))
//                            Spacer().background(.ultraThinMaterial)
                        }
                            .overlay {
                                Text("ARCADE").font(.custom("Tiny5-Regular", size: 38))
                                    .foregroundStyle(.white.gradient
                                )

                                .shadow(color: .black, radius:0.2, x: -1, y: -1)
//                                .background(.ultraThinMaterial)
                            }
                            .frame(width: UIScreen.main.bounds.width * 0.5, height: UIScreen.main.bounds.width * 0.2)
                            .padding(3)
                            .background {
                                HStack(spacing: 0){
                                    ForEach([0.0, 0.1, 0.16, 0.35, 0.6, 0.8], id:\.self){ color in
                                        Rectangle().foregroundStyle(Color(hue: color , saturation: 1, brightness: 0.8).gradient)
                                    }
                                }
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                        
                    }
                    Spacer()
                    Button{
                        // settigns
                        settings = true
                    }label: {
                        HStack{
                            Image(systemName: "gear")
                            Text("Settings")
                        }.font(.custom("Tiny5-Regular", size: 20)).foregroundStyle(.black)
                    }
                }
                .transition(.move(edge: .bottom))
            }
            
        }
        
        .sheet(isPresented: $settings , content: {
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
