//
//  MenuView.swift
//  Instinct
//
//  Created by Christian Rodriguez on 10/23/23.
//

import SwiftUI

struct MenuView: View {
    @AppStorage(PlayerConfigKeys.saturation) private var saturation: Double = 1.0
    @AppStorage(PlayerConfigKeys.soundEffects) private var soundEffects: Bool = true
    @AppStorage(PlayerConfigKeys.level) private var level: Int = 3


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
//                            HStack(spacing: 0){
//                                ForEach([0.0, 0.1, 0.16, 0.35, 0.6, 0.8], id:\.self){ color in
//                                    Rectangle().foregroundStyle(Color(white: color).gradient)
//                                }
//                            }
                            RoundedRectangle(cornerRadius: 10).foregroundStyle(Color(hue: 0.0, saturation:saturation, brightness:1))

//                            Spacer().background(.ultraThinMaterial)
                        }
                            .overlay {
                                Text("CLASSiC").font(.custom("Tiny5-Regular", size: 38))
                                    .foregroundStyle(.white.gradient
                                )

                                .shadow(color: .black, radius:0.2, x: -1, y: -1)
//                                .background(.ultraThinMaterial)
                            }
                            .frame(width: UIScreen.main.bounds.width * 0.5, height: UIScreen.main.bounds.width * 0.2)                            .padding(3)
                            .background {
//                                HStack(spacing: 0){
//                                    ForEach([0.0, 0.1, 0.16, 0.35, 0.6, 0.8], id:\.self){ color in
//                                        Rectangle().foregroundStyle(Color(white: color).gradient)
//                                    }
//                                }
                                Rectangle().foregroundStyle(Color(hue: 0.0, saturation:saturation, brightness:0.8))
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 12))

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
                                    Rectangle().foregroundStyle(Color(hue: color , saturation: saturation, brightness: 0.9).gradient)
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
                                        Rectangle().foregroundStyle(Color(hue: color , saturation: saturation, brightness: 0.8).gradient)
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
        .onAppear {
                print("Level: \(level), saturation: \(saturation), Sound Effects: \(soundEffects)")
            
            gameVm.slotCount = level
        }
        .sheet(isPresented: $settings , content: {
            VStack{
                // preference settings
                Form(content: {
                    VStack {
                        HStack(spacing:0){
                            ForEach([0.0, 0.1, 0.15 ,0.2, 0.25, 0.3, 0.4, 0.5, 0.6,0.8], id:\.self){ i in
                                Rectangle()
                                    .foregroundStyle(Color(hue: i, saturation: saturation, brightness: 1))
                                    .frame(width: UIScreen.main.bounds.width * 0.05, height: UIScreen.main.bounds.width * 0.05)

//                                    .shadow(color: Color(hue: i, saturation: saturation, brightness: 0.5), radius: 1, x: 0, y: -3)
                            }
                        }
                        .padding(.leading, 3)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        .frame(width: UIScreen.main.bounds.width * 0.1)
                        Slider(value: $saturation, in: 0.2...1.5, step: 0.01)
                                    .padding()
                                    .tint(Color(hue: 0, saturation: saturation, brightness: 1))
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
