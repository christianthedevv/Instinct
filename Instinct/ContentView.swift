//
//  ContentView.swift
//  Instinct
//
//  Created by Christian Rodriguez on 10/23/23.
//

import SwiftUI
import SwiftData
struct ContentView: View {
    @AppStorage(PlayerConfigKeys.saturation) private var saturation: Double = 1.0
    @AppStorage(PlayerConfigKeys.soundEffects) private var soundEffects: Bool = true
    @AppStorage(PlayerConfigKeys.level) private var level: Int = 3
    
    @StateObject var gameVm = GameViewModel()
    @State var launched: Bool = false

    var body: some View {
        NavigationView{
            ZStack{
                if gameVm.gameState == .menu {
                    LaunchView(launched: $launched, goal: [.init(letter: "i", color: Color(hue: 0, saturation: saturation, brightness: 1)), .init(letter: "N", color: Color(hue: 0.1, saturation: saturation, brightness: 1)), .init(letter: "S", color: Color(hue: 0.15, saturation: saturation, brightness: 1)), .init(letter: "T", color: Color(hue: 0.2, saturation:saturation, brightness: 1)), .init(letter: "i", color: Color(hue: 0.3, saturation: saturation, brightness: 1)), .init(letter: "N", color: Color(hue: 0.5, saturation: saturation, brightness: 1)), .init(letter: "C", color: Color(hue: 0.7, saturation: saturation, brightness: 1)), .init(letter: "T", color: Color(hue: 0.8, saturation: saturation, brightness: 1))])
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
            .background(Color.background)
        }
        .background(Color.background)
        .environmentObject(gameVm)
    }
}


#Preview {
    ContentView()
}
