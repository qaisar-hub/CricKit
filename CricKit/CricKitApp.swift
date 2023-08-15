//
//  CricKitApp.swift
//  CricKit
//
//  Created by Qaisar Raza on 05/08/23.
//

import SwiftUI

@main
struct CricKitApp: App {
    var body: some Scene {
        WindowGroup {
            LaunchAnimationView()
        }
    }
}

struct LaunchAnimationView: View {
    @State private var isAnimationComplete = false
    @State private var backgroundColor = Color.appPrimary
    
    var body: some View {
        ZStack {
            backgroundColor
            
            if isAnimationComplete {
                ContentView()
                    .transition(.opacity)
            } else {
                AnimationView(isAnimationComplete: $isAnimationComplete, backgroundColor: $backgroundColor)
                    .transition(.opacity)
            }
        }
        .ignoresSafeArea()
    }
}

struct AnimationView: View {
    @Binding var isAnimationComplete: Bool
    @Binding var backgroundColor: Color
    @State private var showSlogan = false
    
    var body: some View {
        VStack {
            Image("appLogo")
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
                .opacity(0.9)
                .onAppear {
                    withAnimation(.easeInOut(duration: 3)) {
                        backgroundColor = Color.appBlacks
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        withAnimation(.easeInOut(duration: 1)) {
                            showSlogan = true
                        }
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                        withAnimation {
                            isAnimationComplete = true
                        }
                    }
                }
            
            if showSlogan {
                TypingText(text: "C r i c K i t")
                    .padding()
                    .fontWidth(.expanded)
                    .font(.system(size: 30))
                    .fontWeight(.bold)
                    .foregroundStyle(.linearGradient(colors: [Color.appPrimary, Color.appSecondary, Color.appPrimary], startPoint: .topLeading, endPoint: .bottomTrailing))
            }
        }
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




struct ContentView: View {
    var body: some View {
        SignInPage()
    }
}

