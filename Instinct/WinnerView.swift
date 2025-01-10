//
//  WinnerView.swift
//  Instinct
//
//  Created by Christian Rodriguez on 10/23/23.
//

import SwiftUI

struct WinnerView: View {
    @EnvironmentObject var gameVm : GameViewModel
    @AppStorage(PlayerConfigKeys.saturation) private var saturation: Double = 1.0
    @AppStorage(PlayerConfigKeys.soundEffects) private var soundEffects: Bool = true
    @AppStorage(PlayerConfigKeys.level) private var level: Int = 3
    @AppStorage(PlayerConfigKeys.haptics) private var haptics: Bool = true
    var body: some View {
        ZStack{
            Color.background.ignoresSafeArea()
            RainfallConfettiView()
            VStack(spacing: 75){
                VStack(spacing:0){
                        Text("YOU WIN!").foregroundStyle(.green).font(.custom("Tiny5-Regular", size: 60))
                        .shadow(color: .text, radius:0.2, x: -2, y: -2)

                }
                VStack(spacing:35){
                    Button {
                        if haptics{
                            let impactMed = UIImpactFeedbackGenerator(style: .soft)
                                impactMed.impactOccurred()
                        }
                        withAnimation{
                           gameVm.gameState = .start
                       }
                    }label: {
                        Text("PLAY AGAIN")
                            .font(.custom("Tiny5-Regular", size: 35))
                            .foregroundStyle(.text)
                            .shadow(color: .inverseText, radius:0.2, x: -1, y: -1)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 3)
                            .background(RoundedRectangle(cornerRadius: 10).stroke( .text, lineWidth: 2))


                    }
                    Button {
                        if haptics{
                            let impactMed = UIImpactFeedbackGenerator(style: .soft)
                                impactMed.impactOccurred()
                        }
                         withAnimation{
                            gameVm.gameState = .menu
                        }
                    }label: {
                        Text("MENU")
                            .font(.custom("Tiny5-Regular", size: 25))
                            .foregroundStyle(.text)
                            .shadow(color: .inverseText, radius:0.2, x: -1, y: -1)
                        


                    }
                }
            }.onAppear {
                level += 1
        }
        }
        .background(Color.background)

    }
}

#Preview {
    WinnerView()
}

import SwiftUI

struct RainfallConfettiView: View {
    @State private var confetti: [Confetti] = []
    let confettiCount = 50

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(confetti) { confetti in
                    Rectangle()
                        .fill(confetti.color.gradient)
                        .frame(width: confetti.size, height: confetti.size)
                        .position(confetti.position)
//                        .rotationEffect(confetti.rotation)
                        .animation(
                            Animation.linear(duration: confetti.duration)
                                .repeatForever(autoreverses: false),
                            value: confetti.position
                        )
                        .animation(
                            Animation.linear(duration: confetti.rotationDuration)
                                .repeatForever(autoreverses: false),
                            value: confetti.rotation
                        )
                }
            }
            .onAppear {
                generateConfetti(in: geometry.size)
            }
        }
        .ignoresSafeArea()
    }

    private func generateConfetti(in size: CGSize) {
        confetti = (0..<confettiCount).map { _ in
            let width = CGFloat.random(in: 10...15)
            return Confetti(
                id: UUID(),
                color: Color.random,
                size: width,
                position: CGPoint(x: CGFloat.random(in: 0...size.width), y: -width),
                destination: CGPoint(x: CGFloat.random(in: 0...size.width), y: size.height + width),
                rotation: Angle(degrees: Double.random(in: 0...960)),
                rotationTarget: Angle(degrees: Double.random(in: 720...1080)),
                rotationDuration: Double.random(in: 2...4),
                duration: Double.random(in: 2...4)
            )
        }

        for index in confetti.indices {
            withAnimation {
                confetti[index].position = confetti[index].destination
                confetti[index].rotation = confetti[index].rotationTarget
            }
        }
    }
}

struct Confetti: Identifiable {
    let id: UUID
    let color: Color
    let size: CGFloat
    var position: CGPoint
    let destination: CGPoint
    var rotation: Angle
    let rotationTarget: Angle
    let rotationDuration: Double
    let duration: Double
}

extension Color {
    static var random: Color {
        Color(hue: Double.random(in: 0...1), saturation: 0.8, brightness: 0.9)
    }
}

struct RainfallConfettiView_Previews: PreviewProvider {
    static var previews: some View {
        RainfallConfettiView()
    }
}
