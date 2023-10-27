//
//  GameViewModel.swift
//  Instinct
//
//  Created by Christian Rodriguez on 10/23/23.
//

import SwiftUI
import AVFAudio

@MainActor
class GameViewModel: ObservableObject {
    // GAME PHASE STUFF
    @Published var gameState: GameState = .menu {
        didSet {
            switch gameState {
            case .menu:
                print("gameState: menu")
            case .start:
                self.slots = [:]
                print("gameState: start")
            case .over:
//                if didWin{
//                    self.playSounds("youWin", fileExtension: ".m4a")
//
//                }else{
//                    self.playSounds("gameOver", fileExtension: ".wav")
//                }
                self.playSounds("", fileExtension: "")
                print("gameState: over")
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
                print("gameStep: placing")
            case .randomizing:
                print("gameStep: randomizing")
                //play slot machine sound
                    if self.gameMode == .arcade{
                        self.randomizeColors()
                    }
                    if self.gameMode == .classic {
                        self.randomizeNumber()
                    }
            }
        }
    }
    @Published var spinning: Bool = false
    
    //Audio Shit
    @Published var audioPlayer: AVAudioPlayer!
    
    // Dictionary that gets populated by user
    @Published var slots : [Int:Int] = [:]
    @Published var slotCount = 10
    
    // Items for number game mode
    @Published var number: Double = 0
    
    func randomizeNumber() {
        for i in 0...20 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1 * Double(i)) {
                withAnimation(.spring){
                    self.number = .random(in: 0 ..< 100)
                }
                let impactMed = UIImpactFeedbackGenerator(style: .rigid)
                    impactMed.impactOccurred()
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            while self.slots.contains(where: { $0.value == Int(self.number)}){
                print("duplicate randomizer")
                self.number = .random(in: 0 ..< 100)

            }
            self.gameStep = .placing
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
        for i in 0...22 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1 * Double(i)) {
                self.color = .random(in: 0 ..< Double(self.totalColors))    
                let impactMed = UIImpactFeedbackGenerator(style: .rigid)
                    impactMed.impactOccurred()
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            while self.slots.contains(where: { $0.value == Int(self.color)}){
                print("duplicate randomizer")
                self.color = .random(in: 0 ..< Double(self.totalColors))

            }
            self.gameStep = .placing
        }
    }
    
    @Published var didWin = false
    
    func populateSlot(content: Int, index: Int){
        self.slots[index] = content
        self.assessSlots(content: content, index: index)
    }
    
    
    func assessSlots(content: Int, index: Int){
        // LHS Check
        for i in 0...index{
            if let slot = self.slots[i] {
                if slot > content {
                    print("Game Over")
                    withAnimation {
                        self.gameState = .over
                    }
                }else{
                    print("Game Continue")
                    self.finalAssessment()
                }
            }
        }
//        RHS Check
        for i in index...self.slotCount{
            if let slot = self.slots[i] {
                if slot < content {
                    print("Game Over")
                    withAnimation {
                        self.gameState = .over
                        self.didWin = false
                    }
                }else{
                    print("Game Continue")
                    self.finalAssessment()
                }
            }
        }

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
                            self.didWin = false
                            self.gameState = .over
                        }
                        return
                    }
                }
            }
            withAnimation{
                self.didWin = true
                self.gameState = .over
            }
        }else{
            return
        }
    }
    
    func playSounds(_ soundFileName : String, fileExtension: String) {
        if self.gameState == .over && didWin {
            if let soundURL = Bundle.main.url(forResource: "youWin", withExtension: ".m4a"){
                do {
                    audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                    audioPlayer.play()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        if self.gameState == .over && !didWin {
            if let soundURL = Bundle.main.url(forResource: "gameOver", withExtension: ".wav"){
                do {
                    audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                    audioPlayer.play()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }else{
            // Have a toggle to mute sound in app
            if let soundURL = Bundle.main.url(forResource: soundFileName, withExtension: fileExtension){
                do {
                    audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                    audioPlayer.play()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}
enum GameState {
    case menu
    case start
    case over
}
enum GameMode {
    case classic
    case arcade
}
enum GameStep {
    case randomizing
    case placing
}
