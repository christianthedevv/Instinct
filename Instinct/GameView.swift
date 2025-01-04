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
    
    @Namespace private var animation
    @EnvironmentObject var gameVm : GameViewModel

    var body: some View {
        switch gameVm.gameMode {
        case .arcade:
            ZStack{
//                switch gameVm.gameStep {
//                case .randomizing:
//                    RandomizerActiveView()
//                        .transition(.asymmetric(insertion: .scale, removal: .scale))
//                case .placing:
                    PlacingActiveView()
//                        .transition(.asymmetric(insertion: .scale, removal: .scale))
//                }
            }.onAppear(perform: {
                withAnimation {
                    gameVm.gameStep = .randomizing
                }
            })
        case .classic:
            ZStack{
                HStack(spacing: 50){
                    VStack{
                        ForEach(0..<gameVm.slotCount){ i in
                            ClassicSlot(index: i)
                        }
                    }.frame(width: 65).padding(.vertical)
                    VStack(spacing: 25){
                        Button{
                            let impactMed = UIImpactFeedbackGenerator(style: .rigid)
                                impactMed.impactOccurred()
                            withAnimation {
                                gameVm.gameState = .lose
                            }
                        }label: {
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(.red, lineWidth: 5)
                                    .overlay {
                                        Text("QUIT").font(.custom("Monda-Bold", size: 25)).foregroundStyle(.red)
                                    }.frame(width: 100, height: 65)
                        }
                            RoundedRectangle(cornerRadius: 20)
                                    .stroke(.black, lineWidth: 3)
                            .frame(width: 130, height: 130)
                            .animatingNumberOverlay(for: gameVm.number)
                        }
                    }

            }.onAppear(perform: {
                withAnimation {
                    gameVm.gameStep = .randomizing
                }
            })
        }

    }
    
    @ViewBuilder
    func RandomizerActiveView() -> some View {
        HStack(spacing: 20){
            // slots
            VStack(spacing:0){
                ScrollView{
                    VStack(spacing:5){
                        ForEach(0..<gameVm.slotCount){ i in
                            ArcadeSlot(index: i)
                        }
                    }
                    .padding()
                }
            }
                .matchedGeometryEffect(id: "Slots", in: animation)
                .frame(width: UIScreen.main.bounds.width * 0.5)
           

            
            VStack(spacing: 25){
                // Randomizer
                SplashView(animationType: .topToBottom, color: Color(hue: gameVm.colorHues[Int(gameVm.color)], saturation: saturation, brightness: 1))
                    .frame(width: UIScreen.main.bounds.width * 0.35, height: UIScreen.main.bounds.width * 0.35)
                    .cornerRadius(10)
                    .shadow(color: Color(hue: gameVm.colorHues[Int(gameVm.color)], saturation: saturation, brightness: 0.5), radius: 1, x: -3, y: -3)
                    .matchedGeometryEffect(id: "Randomizer", in: animation)
                Button{
                    let impactMed = UIImpactFeedbackGenerator(style: .rigid)
                        impactMed.impactOccurred()
                    withAnimation {
                        gameVm.gameState = .lose
                    }
                }label: {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.red, lineWidth: 5)
                            .overlay {
                                Text("QUiT").font(.custom("Tiny5-Regular", size: 25)).foregroundStyle(.red)
                            }.frame(width: 100, height: 65)
                }

                }
            }
    }
    @ViewBuilder
    func PlacingActiveView() -> some View {
        HStack(alignment:.center,spacing: 20){
            
            VStack(spacing:0){
                ForEach([0.0, 0.1, 0.15 ,0.2, 0.25, 0.3, 0.4, 0.5, 0.6,0.8], id:\.self){ i in
                    Rectangle()
                        .foregroundStyle(Color(hue: i, saturation: saturation, brightness: 1))
                        .frame(width: UIScreen.main.bounds.width * 0.05, height: UIScreen.main.bounds.width * 0.05)

                        .shadow(color: Color(hue: i, saturation: saturation, brightness: 0.5), radius: 1, x: -3, y: 0)
                }
            }
            .padding(.leading, 3)
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .frame(width: UIScreen.main.bounds.width * 0.1)
            // slots
//                ScrollView{
                    VStack(spacing:0){
                        ForEach(0..<gameVm.slotCount){ i in
                            ArcadeSlot(index: i)
                        }
                    }
                    .padding(.leading, 3)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .frame(width: UIScreen.main.bounds.width * 0.35)

//                }
                .scrollIndicators(.hidden)                .matchedGeometryEffect(id: "Slots", in: animation)
            
            VStack(spacing: 25){
                // Randomizer
                SplashView(animationType: .topToBottom, color: Color(hue: gameVm.colorHues[Int(gameVm.color)], saturation: saturation, brightness: 1))
                    .frame(width: UIScreen.main.bounds.width * 0.35, height: UIScreen.main.bounds.width * 0.35)
                    .cornerRadius(10)
                    .shadow(color: Color(hue: gameVm.colorHues[Int(gameVm.color)], saturation: saturation, brightness: 0.5), radius: 1, x: -3, y: -3)
                    .matchedGeometryEffect(id: "Randomizer", in: animation)
                Button{
                    let impactMed = UIImpactFeedbackGenerator(style: .rigid)
                        impactMed.impactOccurred()
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
                let impactMed = UIImpactFeedbackGenerator(style: .medium)
                    impactMed.impactOccurred()
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
                let impactMed = UIImpactFeedbackGenerator(style: .medium)
                    impactMed.impactOccurred()
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
                        .frame(width: UIScreen.main.bounds.width * 0.2, height: UIScreen.main.bounds.width * 0.2)

                        .shadow(color: Color(hue: gameVm.colorHues[gameVm.slots[index]!], saturation: saturation, brightness: 0.5), radius: 1, x: -3, y: 0)


//                        .frame(height: 65)
                }else{
                    Rectangle()
                        .foregroundStyle(Color(white: 0.8).gradient)
                        .frame(width: UIScreen.main.bounds.width * 0.2, height: UIScreen.main.bounds.width * 0.2)
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
