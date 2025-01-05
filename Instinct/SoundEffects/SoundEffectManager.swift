//
//  SoundEffectManager.swift
//  Instinct
//
//  Created by Christian Rodriguez on 10/27/23.
//

import Foundation
import AVFAudio
import AVKit
import Foundation
import SwiftUI
import AVFoundation

class SoundEffectManager: NSObject, ObservableObject, AVAudioPlayerDelegate {
    @AppStorage(PlayerConfigKeys.saturation) private var saturation: Double = 1.0
    @AppStorage(PlayerConfigKeys.soundEffects) private var soundEffects: Bool = true
    @AppStorage(PlayerConfigKeys.level) private var level: Int = 3
    @AppStorage(PlayerConfigKeys.haptics) private var haptics: Bool = true
    
    @Published var isPlaying: Bool = false {
        willSet {
            if newValue == true {
//                playAudio()
                try! AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            }
            if newValue == false {
                //pause
                try! AVAudioSession.sharedInstance().setActive(false, options: .notifyOthersOnDeactivation)

            }
        }
    }

    var myAudioPlayer = AVAudioPlayer()
    var fileName = ""

    override init() {
        super.init()
        try! AVAudioSession.sharedInstance().setCategory(
            AVAudioSession.Category.playback,
            mode: AVAudioSession.Mode.default,
            options: [
                AVAudioSession.CategoryOptions.duckOthers
            ]
        )
    }

    func playAudio(soundName: String, fileType: String) {
        if self.soundEffects{
            try! AVAudioSession.sharedInstance().setCategory(
                AVAudioSession.Category.playback,
                mode: AVAudioSession.Mode.default,
                options: [
                    AVAudioSession.CategoryOptions.mixWithOthers
                ]
            )
            try! AVAudioSession.sharedInstance().setActive(true)
            let path = Bundle.main.path(forResource: soundName, ofType:fileType)
            let url = URL(fileURLWithPath: path ?? "gameOver.wav")
            print("Playing Sound: ", soundName)

            do {
                myAudioPlayer = try AVAudioPlayer(contentsOf: url)
                myAudioPlayer.delegate = self
                myAudioPlayer.play()
            } catch {
                // couldn't load file :(
            }
        }
    }

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        isPlaying = false
    }

}
//class SoundEffectManager: ObservableObject {
//    @Published var audioPlayer: AVAudioPlayer!
//
//    func playSounds(_ soundFileName : String, fileExtension: String) {
//        if let soundURL = Bundle.main.url(forResource: soundFileName, withExtension: fileExtension){
//            do {
//                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
//                audioPlayer.play()
//            } catch {
//                print(error.localizedDescription)
//            }
//        }
//    }
//}
