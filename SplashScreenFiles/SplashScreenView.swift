//
//  SplashScreenView.swift
//  YumeSekai
//
//  Created by Deepanshu Bajaj on 06/05/25.
//

import SwiftUI
import SDWebImageSwiftUI

public struct SplashScreenView: View {
    @State private var isAnimating = false
    @Binding var isActive: Bool
    @StateObject private var audioViewModel = AudioViewModel()
    
    public init(isActive: Binding<Bool>) {
        self._isActive = isActive
    }
    
    public var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 0) {
                    // Your new image from OtherAssets
                    if let imageURL = Bundle.main.url(forResource: "yumeSekaiText", withExtension: "jpg") {
                        Image(uiImage: UIImage(contentsOfFile: imageURL.path) ?? UIImage())
                            .resizable()
                            .scaledToFit()
                            .frame(width: geometry.size.width, height: 300)
                            .opacity(isAnimating ? 1 : 0)
                            .offset(y: -90)
                    }
                    
                    // GIF Animation
                    if let gifURL = Bundle.main.url(forResource: "coverPage", withExtension: "gif") {
                        AnimatedImage(url: gifURL)
                            .resizable()
                            .frame(width: geometry.size.width * 0.9, height: 500)
                            .opacity(isAnimating ? 1 : 0)
                            .scaleEffect(isAnimating ? 1 : 0.8)
                            .offset(y: -200)
                    }
                    
                    // Credit Text
                    Text("Designed & Developed By:")
                        .font(.system(size: 16, weight: .light, design: .rounded))
                        .foregroundColor(.white)
                        .opacity(isAnimating ? 0.8 : 0)
                        .offset(y: -180)
                    
                    Text("Deepanshu Bajaj")
                        .font(.system(size: 20, weight: .semibold, design: .rounded))
                        .foregroundColor(.white)
                        .opacity(isAnimating ? 1 : 0)
                        .offset(y: -180)
                }
                .padding()
            }
        }
        .onAppear {
            withAnimation(.easeOut(duration: 0.8)) {
                isAnimating = true
            }
            
            // Start playing audio
            audioViewModel.startPlayback()
            
            // After animation duration + some buffer, mark splash screen as done
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                withAnimation {
                    isActive = false
                }
            }
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView(isActive: .constant(true))
    }
} 
