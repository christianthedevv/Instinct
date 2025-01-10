//
//  GameView.swift
//  Instinct
//
//  Created by Christian Rodriguez on 10/23/23.
//

import SwiftUI
import AVFAudio

struct GameView: View {
    @AppStorage(PlayerConfigKeys.saturation) private var saturation: Double = 1.0
    @AppStorage(PlayerConfigKeys.soundEffects) private var soundEffects: Bool = true
    @AppStorage(PlayerConfigKeys.level) private var level: Int = 3
    @AppStorage(PlayerConfigKeys.haptics) private var haptics: Bool = true
    
    @Namespace private var animation
    @EnvironmentObject var gameVm : GameViewModel
    @State var info = false

    var body: some View {
        
            ZStack{
                VStack{
                    HStack{
                        Spacer()
                        Button{
                            info.toggle()
                        }label: {
                            Text("i").font(.custom("Tiny5-Regular", size: 35))
                                .foregroundStyle(.black).padding(.horizontal, 30)

                        }.sheet(isPresented: $info) {
                            InfoView()
                        }
                    }
                    Spacer()
                    gameView()
                    Spacer()

                }
            }
            .background(Color.background)
            .onAppear(perform: {
                withAnimation {
                    gameVm.gameStep = .randomizing
                }
            })

    }
    @ViewBuilder
    func gameView() -> some View {
        HStack(alignment:.center,spacing: 20){
            
            
                    VStack(spacing:0){
                        ForEach(0..<(gameVm.gameMode == .classic ? 10 : level)){ i in
                            ArcadeSlot(index: i)
                        }
                    }
                    .padding(.leading, 3)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                .scrollIndicators(.hidden)
                .matchedGeometryEffect(id: "Slots", in: animation)
            
            VStack(spacing: 25){
                // Randomizer
                SplashView(animationType: .topToBottom, color: Color(hue: gameVm.colorHues[Int(gameVm.color)], saturation: saturation, brightness: 1))
                    .frame(width: UIScreen.main.bounds.width * 0.35, height: UIScreen.main.bounds.width * 0.35)
                    .cornerRadius(10)
                    .shadow(color: Color(hue: gameVm.colorHues[Int(gameVm.color)], saturation: saturation, brightness: 0.5), radius: 1, x: -3, y: -3)
                    .matchedGeometryEffect(id: "Randomizer", in: animation)
                Button{
                    if haptics{
                        let impactMed = UIImpactFeedbackGenerator(style: .rigid)
                            impactMed.impactOccurred()
                    }
                    withAnimation {
                        gameVm.gameState = .lose
                    }
                }label: {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(Color(hue:0, saturation: saturation, brightness: 1).gradient)
                        .shadow(color:Color(hue: 0, saturation: saturation, brightness: 0.5) ,radius: 1, x: -2, y: -1)
                            .overlay {
                                Text("QUiT").font(.custom("Tiny5-Regular", size: 25)).foregroundStyle(.white)
                                    .shadow(color:.black ,radius: 1, x: -1, y: -1)
                            }.frame(width: 100, height: 65)
                }
                }
            }
    }
    
    @ViewBuilder
    func ClassicSlot(index: Int) -> some View{
        var isPopulated = gameVm.slots.contains(where: { $0.key == index})
        ZStack{
            Button{
                if haptics{
                    let impactMed = UIImpactFeedbackGenerator(style: .medium)
                        impactMed.impactOccurred()
                }
                gameVm.audio.playAudio(soundName: String(gameVm.progress), fileType: "wav")
                withAnimation {
                    gameVm.populateSlot(content: Int(gameVm.number), index: index)
                    gameVm.gameStep = .randomizing
                }
//                print(gameVm.slots)
                gameVm.progress += 1
            }label: {
                RoundedRectangle(cornerRadius: 10)
                        .stroke(.black, lineWidth: 2)
                        .overlay {
                            Text(gameVm.slots.contains(where: { $0.key == index}) ? String(gameVm.slots[index]!) : "").font(.custom("Monda-Bold", size: 15))
                        }.frame(height: 65)
            }.disabled(gameVm.gameStep == .randomizing || gameVm.slots.contains(where: { $0.key == index}))
        }
    }
    
    @ViewBuilder
    func ArcadeSlot(index: Int) -> some View{
        var isPopulated = gameVm.slots.contains(where: { $0.key == index})
//        ZStack{
            Button{
                if haptics{
                    let impactMed = UIImpactFeedbackGenerator(style: .medium)
                        impactMed.impactOccurred()
                }
                gameVm.audio.playAudio(soundName: String(gameVm.progress), fileType: "wav")
                withAnimation {
                    gameVm.populateSlot(content: Int(gameVm.color), index: index)
                    gameVm.gameStep = .randomizing
                }
//                print(gameVm.slots)
                gameVm.progress += 1
            }label: {
                if isPopulated {
                    Rectangle()
                        .foregroundStyle(isPopulated ? Color(hue: gameVm.colorHues[gameVm.slots[index]!], saturation:saturation, brightness: 1) : Color.clear)
                        .frame(width: UIScreen.main.bounds.width * 0.18, height: UIScreen.main.bounds.width * 0.18)

                        .shadow(color: Color(hue: gameVm.colorHues[gameVm.slots[index]!], saturation: saturation, brightness: 0.5), radius: 1, x: -3, y: 0)


//                        .frame(height: 65)
                }else{
                    Rectangle()
                        .foregroundStyle(Color(white: 0.8).gradient)
                        .frame(width: UIScreen.main.bounds.width * 0.18, height: UIScreen.main.bounds.width * 0.18)
                        .shadow(color: .gray, radius: 1, x: -3, y: 0)

//                        .frame(height: 65)
                }
            }.disabled(gameVm.gameStep == .randomizing || isPopulated)
            
//        }
    }
    
}

#Preview {
    GameView().environmentObject(GameViewModel())
}
