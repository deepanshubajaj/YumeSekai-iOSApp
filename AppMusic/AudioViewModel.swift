//
//  AudioViewModel.swift
//  YumeSekai
//
//  Created by Deepanshu Bajaj on 18/05/25.
//

import Foundation
import SwiftUI

public class AudioViewModel: ObservableObject {
    @Published public var isMuted = false
    private let audioManager = AudioManager.shared
    
    public init() {}
    
    public func toggleMute() {
        isMuted.toggle()
        audioManager.toggleMute()
    }
    
    public func startPlayback() {
        audioManager.startPlayback()
    }
    
    public func stopPlayback() {
        audioManager.stopPlayback()
    }
} 
