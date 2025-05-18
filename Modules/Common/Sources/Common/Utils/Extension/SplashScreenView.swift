import SwiftUI
import SDWebImageSwiftUI

public struct SplashScreenView: View {
    @State private var isAnimating = false
    @Binding var isActive: Bool
    
    public init(isActive: Binding<Bool>) {
        self._isActive = isActive
    }
    
    public var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            if let gifURL = Bundle.main.url(forResource: "coverPage", withExtension: "gif") {
                AnimatedImage(url: gifURL)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .opacity(isAnimating ? 1 : 0)
                    .scaleEffect(isAnimating ? 1 : 0.8)
            }
        }
        .onAppear {
            withAnimation(.easeOut(duration: 0.8)) {
                isAnimating = true
            }
            
            // After animation duration + some buffer, mark splash screen as done
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
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