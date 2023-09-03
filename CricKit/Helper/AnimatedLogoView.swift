//
//  AnimatedTitleView.swift
//  CricKit
//
//  Created by Qaisar Raza on 03/09/23.
//

import SwiftUI

struct AnimatedLogoView: View {
    @Binding var isAnimationComplete: Bool
    @State private var showAppName = false
    @State private var isStartAnimating = true
    
    var body: some View {
        ZStack {
            HStack(spacing: 10) {
                ZStack {
                    Circle()
                        .fill(ColorManager.appPrimaryColor())
                        .frame(width: isStartAnimating ? 70: 40, height: isStartAnimating ?  70: 40)
                        .animation(Animation.easeInOut(duration: 1.5).delay(1), value: isStartAnimating)
                    Image("batsman")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                withAnimation(.easeInOut(duration: 1)) {
                                    showAppName = true
                                }
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                                withAnimation {
                                    isAnimationComplete = true
                                }
                            }
                        }
                }
                
                if showAppName {
                    TypingText(text: "CricKit")
                        .fontWidth(.expanded)
                        .font(.system(size: 40))
                        .fontWeight(.bold)
                        .foregroundColor(ColorManager.appPrimaryColor())
                }
            }
            .onAppear {
                withAnimation {
                    isStartAnimating.toggle()
                }
            }
            
        }
        .padding(.all)
    }
}

struct TypingText: View {
    let text: String
    @State private var currentIndex = 0
    @State private var timer: Timer?
    
    var body: some View {
        Text(text.prefix(currentIndex))
            .onAppear {
                startTypingAnimation()
            }
    }
    
    private func startTypingAnimation() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            if currentIndex < text.count {
                currentIndex += 1
            } else {
                timer?.invalidate()
            }
        }
    }
}

struct AnimatedLogoView_Previews: PreviewProvider {
    static var previews: some View {
        AnimatedLogoView(isAnimationComplete: .constant(false))
    }
}
