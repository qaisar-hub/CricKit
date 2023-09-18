//
//  LaunchAnimationView.swift
//  CricKit
//
//  Created by Qaisar Raza on 18/09/23.
//

import SwiftUI

struct LaunchAnimationView: View {
    @State private var isAnimationComplete = false
    @Binding var showLoading: Bool
    
    var body: some View {
        ZStack {
            if !showLoading {
                CustomBackgroundView()
                
                if isAnimationComplete {
                    ContentView()
                        .transition(.opacity)
                } else {
                    AnimatedLogoView(isAnimationComplete: $isAnimationComplete)
                        .transition(.opacity)
                }
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    LaunchAnimationView(showLoading: .constant(true))
}
