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
            switch gameVm.gameState {
                case .lose:
                    LoserView()
                case .win:
                    WinnerView()
                case .menu:
                    MenuView()
                case .start:
                    GameView()
            }
        }.environmentObject(gameVm)
    }
}

#Preview {
    ContentView()
}
