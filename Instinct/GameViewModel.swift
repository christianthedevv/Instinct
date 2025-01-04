//
//  GameViewModel.swift
//  Instinct
//
//  Created by Christian Rodriguez on 10/23/23.
//

import SwiftUI

@MainActor
class GameViewModel: ObservableObject {
    // GAME PHASE STUFF
    @Published var gameState: GameState = .menu {
        didSet {
            switch gameState {
            case .menu:
                print("gameState: menu")
            case .start:
                self.progress = 0
                self.slots = [:]
                print("gameState: start")
            case .win:
                print("gameState: win")
                self.audio.playAudio(soundName: "youWin", fileType: "m4a")
            case .lose:
                print("gameState: lose")
                self.audio.playAudio(soundName: "gameOver", fileType: "wav")
            }
        }
    }
    @Published var gameMode: GameMode = .arcade {
        didSet {
            switch gameMode {
            case .classic:
                print("gameMode: classic")
            case .arcade:
                print("gameMode: arcade")
            }
        }
    }
    @Published var gameStep: GameStep = .randomizing {
        didSet {
            switch gameStep {
            case .placing:
//                self.audio.playAudio(soundName: "cutOff", fileType: "m4a")
                print("gameStep: placing")
            case .randomizing:
                print("gameStep: randomizing")
//                self.audio.playAudio(soundName: "wheelSpin", fileType: "m4a")
                    if self.gameMode == .arcade{
                        self.randomizeColors()
                    }
                    if self.gameMode == .classic {
                        self.randomizeNumber()
                    }
            }
        }
    }
    // User Settings
    @Published var timerMode: Bool = false
    @Published var haptics: Bool = true
    @Published var soundEffects: Bool = true

    // Other??
    @Published var audio: SoundEffectManager = SoundEffectManager()
    @Published var progress = 0
    
    // Dictionary that gets populated by user
    @Published var slots : [Int:Int] = [:]
    @Published var slotCount = 3
    
    // Items for number game mode
    @Published var number: Double = 0
    
    func randomizeNumber() {
        for i in 0...16 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1 * Double(i)) {
                withAnimation(.spring){
                    self.number = .random(in: 0 ..< 100)
                }
                let impactMed = UIImpactFeedbackGenerator(style: .soft)
                    impactMed.impactOccurred()
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            while self.slots.contains(where: { $0.value == Int(self.number)}){
                print("duplicate randomizer")
                self.number = .random(in: 0 ..< 100)

            }
            withAnimation{
                self.gameStep = .placing
            }
        }

    }
    // Items for color game mode
    var colorHues: [Double] = [0.00001, 0.07, 0.1 , 0.133,
                               0.150, 0.165, 0.190,0.23,
                               0.33, 0.430, 0.465, 0.5,
                               0.53, 0.55, 0.6, 0.7,
                               0.74, 0.76, 0.8, 0.835, 0.9]
    @Published var totalColors = 21
    @Published var color: Double = 0
    
    func randomizeColors(){
        for i in 0...20 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1 * Double(i)) {
                self.color = .random(in: 0 ..< Double(self.totalColors))    
                let impactMed = UIImpactFeedbackGenerator(style: .soft)
                    impactMed.impactOccurred()
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.3) {
            while self.slots.contains(where: { $0.value == Int(self.color)}){
                print("duplicate randomizer")
                self.color = .random(in: 0 ..< Double(self.totalColors))

            }
            withAnimation(.interactiveSpring){
                self.gameStep = .placing
            }
        }
    }
    
    
    func populateSlot(content: Int, index: Int){
        self.slots[index] = content
        self.assessSlots(content: content, index: index)
    }
    
    
    
    func assessSlots(content: Int, index: Int){
        // LHS Check
        var LHS = false
        for i in 0...index{
            if let slot = self.slots[i] {
                if slot > content {
                    print("Game Over")
                    LHS = false
                    withAnimation {
                        self.gameState = .lose
                    }
                }else{
                    LHS = true
                    print("Game Continue")
                    self.finalAssessment()
                }
            }
        }
//        RHS Check
        var RHS = false
        for i in index...self.slotCount{
            if let slot = self.slots[i] {
                if slot < content {
                    print("Game Over")
                    RHS = false
                    withAnimation {
                        self.gameState = .lose
                    }
                }else{
                    RHS = true
                    print("Game Continue")
                    self.finalAssessment()
                }
            }
        }
//        if RHS && LHS {
//            self.audio.playAudio(soundName: String(self.progress), fileType: "wav")
//        }
//        if !RHS || !LHS {
//            self.audio.playAudio(soundName: "gameOver", fileType: "wav")
//        }

    }
    
    func finalAssessment(){
        var last = 0
        if self.slots.count == self.slotCount {
            for i in 0...self.slotCount{
                if let slot = self.slots[i] {
                    if slot >= last {
//                        print(slot, " is greater than ", last)
                        last = slot
                        continue
                    }else{
                        withAnimation{
                            self.gameState = .lose
                        }
                        return
                    }
                }
            }
            withAnimation{

                self.gameState = .win
            }
        }else{
            return
        }
    }
    
}
enum GameState {
    case menu
    case start
    case lose
    case win
}
enum GameMode {
    case classic
    case arcade
}
enum GameStep {
    case randomizing
    case placing
}

import Foundation

struct PlayerConfigKeys {
    static let level = "PlayerConfigLevel"
    static let saturation = "PlayerConfigSaturation"
    static let soundEffects = "PlayerConfigSoundEffects"
}

func savePlayerConfig(level: Int, saturation: Double, soundEffects: Bool) {
    let defaults = UserDefaults.standard
    defaults.set(level, forKey: PlayerConfigKeys.level)
    defaults.set(saturation, forKey: PlayerConfigKeys.saturation)
    defaults.set(soundEffects, forKey: PlayerConfigKeys.soundEffects)
}

func loadPlayerConfig() -> (level: Int, saturation: Double, soundEffects: Bool) {
    let defaults = UserDefaults.standard
    let level = defaults.integer(forKey: PlayerConfigKeys.level) // Default is 0 if not set
    let saturation = defaults.double(forKey: PlayerConfigKeys.saturation) // Default is 0.0 if not set
    let soundEffects = defaults.bool(forKey: PlayerConfigKeys.soundEffects) // Default is false if not set
    
    return (level: level != 0 ? level : 3, saturation: saturation != 0 ? saturation : 1.0, soundEffects: soundEffects)
}
