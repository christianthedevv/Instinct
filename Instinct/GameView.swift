//
//  GameView.swift
//  Instinct
//
//  Created by Christian Rodriguez on 10/23/23.
//

import SwiftUI
import AVFAudio

struct GameView: View {
    @Namespace private var animation
    @EnvironmentObject var gameVm : GameViewModel

    var body: some View {
        if gameVm.gameMode == .classic {
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
        if gameVm.gameMode == .arcade {
            ZStack{
                HStack(spacing: 50){
                    VStack{
                        ForEach(0..<gameVm.slotCount){ i in
                            ArcadeSlot(index: i)
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
                        SplashView(animationType: .topToBottom, color: Color(hue: gameVm.colorHues[Int(gameVm.color)], saturation: 1, brightness: 1))
                            .frame(width: 130, height: 130, alignment: .center)
                            .cornerRadius(10)
                            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 4)
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
        ZStack{
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
                    RoundedRectangle(cornerRadius: 10)
                        .fill(isPopulated ? Color(hue: gameVm.colorHues[gameVm.slots[index]!], saturation: 1, brightness: 1) : Color.clear)
                        .frame(height: 65)
                }else{
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.black, lineWidth: 2)
                        .frame(height: 65)
                }
            }.disabled(gameVm.gameStep == .randomizing || isPopulated)
        }
    }
    
}

#Preview {
    GameView()
}
