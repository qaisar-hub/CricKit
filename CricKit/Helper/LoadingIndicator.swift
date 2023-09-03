//
//  LoadingIndicator.swift
//  CricKit
//
//  Created by Qaisar Raza on 18/08/23.
//

import SwiftUI
import Shimmer

struct LoadingIndicator1: View {
    @State var isAnimated: Bool = false
    var body: some View {
        ZStack{
            ZStack{
                Circle()
                    .stroke(Color(.systemGray5), lineWidth: 14)
                    .frame(width: 50, height: 50)
                
                Circle()
                    .trim(from: 0, to: 0.2)
                    .stroke(Color.red, lineWidth: 7)
                    .frame(width: 50, height: 50)
                    .rotationEffect(Angle(degrees: isAnimated ? 360 : 0))
                    .animation(Animation.linear(duration: 0.7).repeatForever(autoreverses: false), value: isAnimated
                    )
            }
            .padding()
            //.background(Blur(style: .systemChromeMaterialDark))
            .cornerRadius(50)
            .shadow(radius: 10)
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear{
            DispatchQueue.main.async {
                isAnimated = true
            }
        }
        .onDisappear{
            DispatchQueue.main.async {
                isAnimated = false
            }
        }
    }
}

struct LoadingIndicator: View {
    
    @State var  isAnimating: Bool = false
    @EnvironmentObject private var appSettings: AppSettings
    
    var body: some View {
        ZStack{
            VStack {
                Circle()
                    .trim(from: 0.0, to: 0.8)
                    .stroke(Color.red, style: .init(lineWidth: 5, lineCap: .round))
                    .rotationEffect(.degrees( isAnimating ? 360 : 0))
                    .animation( isAnimating ? .linear(duration: 0.5).repeatForever(autoreverses: false) :.default, value:  isAnimating)
                    .frame(width: 30, height: 30, alignment: .center)
                Text("LOADING")
                    .foregroundColor(ColorManager.appTextColor(colorScheme: appSettings.isDarkMode ? .dark : .light))
                    .font(.footnote)
                    .shimmering()
            }
        }
        .padding()
        .background(BlurManagerData.blurMaterial(colorScheme: appSettings.isDarkMode ? .dark : .light))
        .cornerRadius(10)
        .edgesIgnoringSafeArea(.all)
        
        .onAppear{
            DispatchQueue.main.async {
                 isAnimating = true
            }
        }
        .onDisappear{
            DispatchQueue.main.async {
                 isAnimating = false
            }
            
        }
    }
}


struct LoadingIndicator_Previews: PreviewProvider {
    static var previews: some View {
        LoadingIndicator()
            .environmentObject(AppSettings())
    }
}
