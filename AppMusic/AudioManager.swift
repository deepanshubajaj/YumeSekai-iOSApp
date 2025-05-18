//
//  AudioManager.swift
//  YumeSekai
//
//  Created by Deepanshu Bajaj on 18/05/25.
//

import Foundation
import AVFoundation

public class AudioManager {
    public static let shared = AudioManager()
    private var audioPlayer: AVAudioPlayer?
    private var isMuted = false
    
    private init() {
        setupAudio()
    }
    
    private func setupAudio() {
        guard let path = Bundle.main.path(forResource: "Suzume", ofType: "mp3") else {
            print("Could not find audio file")
            return
        }
        
        let url = URL(fileURLWithPath: path)
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.numberOfLoops = -1 // Loop indefinitely
            audioPlayer?.prepareToPlay()
        } catch {
            print("Error loading audio: \(error.localizedDescription)")
        }
    }
    
    public func startPlayback() {
        if !isMuted {
            audioPlayer?.play()
        }
    }
    
    public func stopPlayback() {
        audioPlayer?.stop()
    }
    
    public func toggleMute() {
        isMuted.toggle()
        if isMuted {
            audioPlayer?.pause()
        } else {
            audioPlayer?.play()
        }
    }
    
    public var isPlaying: Bool {
        return audioPlayer?.isPlaying ?? false
    }
} 
