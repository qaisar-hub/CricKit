//
//  CustomBackground.swift
//  CricKit
//
//  Created by Qaisar Raza on 29/08/23.
//

import SwiftUI

struct CustomBackgroundView: View {
    @State var animate: Bool = false
    
    var body: some View {
        ZStack {
            CircleBackground(color: Color.appPrimary)
                .blur(radius: animate ? 50 : 100)
                .offset(x: animate ? -50 : -130, y: animate ? -30 : -100)
                .task {
                    withAnimation(.easeInOut(duration: 7).repeatForever()) {
                        animate.toggle()
                    }
                }
            
            CircleBackground(color: Color.appPrimary.opacity(0.4))
                .blur(radius: animate ? 30 : 100)
                .offset(x: animate ? 100 : 130, y: animate ? 150 : 100)
                .task {
                    withAnimation(.easeInOut(duration: 4).repeatForever()) {
                        animate.toggle()
                    }
                }
            

            
        }
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(
            LinearGradient(gradient: Gradient(colors: [Color.appBlacks]), startPoint: .top, endPoint: .bottom)
        )
    }
}

struct CircleBackground: View {
    @State var color: Color = Color.appPrimary
    
    var body: some View {
        Circle()
            .frame(width: 300, height: 300)
            .foregroundColor(color)
    }
}



struct CustomBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        CustomBackgroundView()
    }
}
