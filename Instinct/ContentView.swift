//
//  ContentView.swift
//  Instinct
//
//  Created by Christian Rodriguez on 10/23/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var gameVm = GameViewModel()
    
    var body: some View {
        ZStack{
            if gameVm.gameState == .menu {
                MenuView()
            }
            if gameVm.gameState == .start {
                GameView()
            }
            if gameVm.gameState == .lose {
                LoserView()
            }
            if gameVm.gameState == .win {
                WinnerView()
            }
        }.environmentObject(gameVm)
    }
}

#Preview {
    ContentView()
}
