//
//  ContentView.swift
//  Instinct
//
//  Created by Christian Rodriguez on 10/23/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var gameVm = GameViewModel()
    @State var launched: Bool = false

    var body: some View {
        ZStack{
            LottieView(animationFileName: "instinctlaunch", loopMode: .playOnce).scaleEffect(0.27).frame(width: UIScreen.main.bounds.width * 0.75,height: UIScreen.main.bounds.height / 2).onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                        withAnimation(.spring){
                            launched = true
                        }
                    }
                
            }
            switch gameVm.gameState {
                case .lose:
                    LoserView()
                case .win:
                    WinnerView()
                case .menu:
                MenuView(launched: $launched)
                case .start:
                    GameView()
            }
        }.environmentObject(gameVm)
    }
}

#Preview {
    ContentView()
}
