//
//  MuteButton.swift
//  YumeSekai
//
//  Created by Deepanshu Bajaj on 18/05/25.
//

import SwiftUI

public struct MuteButton: View {
    @ObservedObject var viewModel: AudioViewModel
    
    public init(viewModel: AudioViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        Button(action: {
            viewModel.toggleMute()
        }) {
            Image(systemName: viewModel.isMuted ? "speaker.slash.fill" : "speaker.wave.2.fill")
                .foregroundColor(.white)
                .font(.system(size: 20))
                .padding(12)
                .background(Color.black.opacity(0.6))
                .clipShape(Circle())
        }
    }
} 
