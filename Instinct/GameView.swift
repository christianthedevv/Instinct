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
    @State var progress = 0
    
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
                                gameVm.gameState = .over
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
                            .frame(width: 150, height: 150)
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
                                gameVm.gameState = .over
                            }
                        }label: {
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(.red, lineWidth: 5)
                                    .overlay {
                                        Text("QUIT").font(.custom("Monda-Bold", size: 25)).foregroundStyle(.red)
                                    }.frame(width: 100, height: 65)
                        }
                        if !gameVm.spinning {
                                RoundedRectangle(cornerRadius: 10)
                                .stroke(.black, lineWidth: 3)
                                .animatingColorBackground(for: gameVm.color)
                                .frame(width: 150, height: 150)
                            }
                        if gameVm.spinning {
                            RoundedRectangle(cornerRadius: 10)
                            .stroke(.black, lineWidth: 3)
                            .foregroundStyle(Color(hue: gameVm.colorHues[Int(gameVm.color)], saturation: 1, brightness: 1))
                            .frame(width: 150, height: 150)
                        }
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
                withAnimation {
                    gameVm.populateSlot(content: Int(gameVm.number), index: index)
                    gameVm.gameStep = .randomizing
                }
                print(gameVm.slots)
                gameVm.playSounds(String(progress), fileExtension: ".wav")
                progress += 1
            }label: {
                RoundedRectangle(cornerRadius: 20)
                        .stroke(.black, lineWidth: 3)
                        .overlay {
                            Text(gameVm.slots.contains(where: { $0.key == index}) ? String(gameVm.slots[index]!) : "")
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
                withAnimation {
                    gameVm.populateSlot(content: Int(gameVm.color), index: index)
                    gameVm.gameStep = .randomizing
                }
                print(gameVm.slots)
                gameVm.playSounds(String(progress), fileExtension: ".wav")
                progress += 1
            }label: {
                if gameVm.slots.contains(where: { $0.key == index}) {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(gameVm.slots.contains(where: { $0.key == index}) ? Color(hue: gameVm.colorHues[gameVm.slots[index]!], saturation: 1, brightness: 1) : Color.clear)
                        .frame(height: 65)
                }else{
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(.black, lineWidth: 2)
                        .frame(height: 65)
                }
            }.disabled(gameVm.gameStep == .randomizing || gameVm.slots.contains(where: { $0.key == index}))
        }
    }
    
}

#Preview {
    GameView()
}
