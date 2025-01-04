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
        NavigationView{
            ZStack{
                if gameVm.gameState == .menu {
                    LaunchView(launched: $launched)
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
            }
        }
        .environmentObject(gameVm)
    }
}

#Preview {
    ContentView()
}
