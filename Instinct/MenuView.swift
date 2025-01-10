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
    @AppStorage(PlayerConfigKeys.haptics) private var haptics:  Bool = true
    @AppStorage(PlayerConfigKeys.onboarded) private var onboarded:  Bool = false


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
                            Text("i").font(.custom("Tiny5-Regular", size: 35))
                                .foregroundStyle(.text).padding(.horizontal, 30)

                        }.sheet(isPresented: $info) {
                            InfoView()
                                .presentationDetents([.large])
                                .presentationBackground(Color.background)
                                    .presentationCornerRadius(20)
                                .background(Color.background)

                        }
                    }
                    Spacer()
                    Button {
                        if haptics {
                            let impactMed = UIImpactFeedbackGenerator(style: .soft)
                            impactMed.impactOccurred()
                        }
                        
                        withAnimation {
                            gameVm.gameMode = .classic
                            gameVm.gameState = .start
                        }
                    }label: {
                        ZStack{
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

                                Rectangle().foregroundStyle(Color(hue: 0.0, saturation:saturation, brightness:0.8))
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 12))

                    }

                    Button {
                        if haptics{
                            let impactMed = UIImpactFeedbackGenerator(style: .soft)
                            impactMed.impactOccurred()
                        }
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
                        }.font(.custom("Tiny5-Regular", size: 20)).foregroundStyle(.text)
                    }
                    .sheet(isPresented: $settings , content: {
                        ZStack{
                            Color.background.ignoresSafeArea()
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
                                        Slider(value: $saturation, in: 0.2...1, step: 0.01)
                                                    .padding()
                                                    .tint(Color(hue: 0, saturation: saturation, brightness: 1))
                                            }
                                    Toggle(isOn: $haptics, label: {
                                        Text("Haptics")
                                    })
                                    Toggle(isOn: $soundEffects, label: {
                                        Text("Sound Effects")
                                    })
                //                    Toggle(isOn: $gameVm.timerMode, label: {
                //                        Text("Timer Mode")
                //                    })
                                })
                            }.font(.custom("Tiny5-Regular", size: 20)).foregroundStyle(.text)
                        }
                        .presentationDetents([.height(300)])
                        .presentationBackground(Color.background)
                            .presentationCornerRadius(20)
                    })
                }
                .transition(.move(edge: .bottom))
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                if !onboarded {
                    info.toggle()
                    onboarded = true
                }
            }
                print("Level: \(level), saturation: \(saturation), Sound Effects: \(soundEffects)")
            
        }
        .sheet(isPresented: $settings , content: {
            VStack{
                // preference settings
                Form(content: {
                    
                    Section{
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
                        ScrollView(.horizontal){
                        HStack{
                                ForEach(["AppIcon", "AppIcon 1","AppIcon 2","AppIcon 3","AppIcon 4","AppIcon 5"], id:\.self){icon in
                                    Button{
                                        changeAppIcon(to: icon)
                                    }label:{
                                        Image(icon).resizable().frame(width: 60, height: 60).cornerRadius(10)
                                    }.buttonStyle(.borderless)
                                }
                            }
                        }
                        
                    }header: {
                        Text("App Appearance").font(.custom("Tiny5-Regular", size: 20)).foregroundStyle(.gray)

                    }
                    
                    Section{
                        Toggle(isOn: $haptics, label: {
                            Text("Haptics")
                        })
                        Toggle(isOn: $soundEffects, label: {
                            Text("Sound Effects")
                        })
                    }header: {
                        Text("Game Settings").font(.custom("Tiny5-Regular", size: 20)).foregroundStyle(.gray)

                    }
//                    Toggle(isOn: $gameVm.timerMode, label: {
//                        Text("Timer Mode")
//                    })
                })
            }.font(.custom("Monda-Regular", size: 20)).foregroundStyle(.black)
        })
    }
}

private func changeAppIcon(to iconName: String) {
        UIApplication.shared.setAlternateIconName(iconName) { error in
            if let error = error {
                print("Error setting alternate icon \(error.localizedDescription)")
            }

        }
    }


#Preview {
    MenuView(launched: .constant(true)).environmentObject(GameViewModel())
}
