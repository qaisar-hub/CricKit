 //
 //  ContentView.swift
 //  EmbossedButton
 //
 //  Created by ephrim.daniel on 30/08/23.
 //
 
 import SwiftUI
 
 extension Color {
     static let offWhite = Color(red: 225 / 255, green: 225 / 255, blue: 235 / 255)
 
     static let darkStart = Color(red: 50 / 255, green: 60 / 255, blue: 65 / 255)
     static let darkEnd = Color(red: 25 / 255, green: 25 / 255, blue: 30 / 255)
 
     static let lightStart = Color(red: 60 / 255, green: 160 / 255, blue: 240 / 255)
     static let lightEnd = Color(red: 30 / 255, green: 80 / 255, blue: 120 / 255)
 }
 
 extension LinearGradient {
     init(_ colors: Color...) {
         self.init(gradient: Gradient(colors: colors), startPoint: .topLeading, endPoint: .bottomTrailing)
     }
 }

 struct SimpleButtonStyle: ButtonStyle {
     func makeBody(configuration: Self.Configuration) -> some View {
         configuration.label
             .padding(30)
             .contentShape(Circle())
             .background(
                 Group {
                     if configuration.isPressed {
                         Circle()
                             .fill(Color.offWhite)
                             .overlay(
                                 Circle()
                                     .stroke(Color.gray, lineWidth: 4)
                                     .blur(radius: 4)
                                     .offset(x: 2, y: 2)
                                     .mask(Circle().fill(LinearGradient(Color.black, Color.clear)))
                             )
                             .overlay(
                                 Circle()
                                     .stroke(Color.white, lineWidth: 8)
                                     .blur(radius: 4)
                                     .offset(x: -4, y: -4)
                                     .mask(Circle().fill(LinearGradient(Color.clear, Color.black)))
                             )
                     } else {
                         Circle()
                             .fill(Color.offWhite)
                             .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
                             .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
                     }
                 }
             )
     }
 }
 
 struct ColorfulBackground<S: Shape>: View {
     var isHighlighted: Bool
     var shape: S
 
     var body: some View {
         ZStack {
             if isHighlighted {
                 shape
                     .fill(LinearGradient(Color.lightEnd, Color.lightStart))
                     .overlay(shape.stroke(LinearGradient(Color.lightStart, Color.lightEnd), lineWidth: 4))
                     .shadow(color: Color.darkStart, radius: 5, x: 3, y: 3)
                     .shadow(color: Color.darkEnd, radius: 5, x: -3, y: -3)
             } else {
                 shape
                     .fill(LinearGradient(Color.darkStart, Color.darkEnd))
                     .overlay(shape.stroke(LinearGradient(Color.lightStart, Color.black), lineWidth: 4))
                     .shadow(color: Color.darkStart, radius: 5, x: -3, y: -3)
                     .shadow(color: Color.darkEnd, radius: 5, x: 3, y: 3)
             }
         }
     }
 }
 
 struct ColorfulButtonStyle: ButtonStyle {
     func makeBody(configuration: Self.Configuration) -> some View {
         configuration.label
             .padding(20)
             .contentShape(Circle())
             .background(
                 ColorfulBackground(isHighlighted: configuration.isPressed, shape: Circle())
             )
     }
 }
 
 
 struct ColorfulButtonStyleRect: ButtonStyle {
     func makeBody(configuration: Self.Configuration) -> some View {
         configuration.label
             .padding(20)
             .contentShape(Rectangle())
             .background(
                 ColorfulBackground(isHighlighted: configuration.isPressed, shape: Rectangle())
             )
     }
 }
 
 struct EmbossedButton: View {
 
     var systemName: String
     var action: () -> Void
 
     var body: some View {
         VStack {
             Button(action: {
                 action()
             }) {
                 Image(systemName: systemName)
                     .foregroundColor(.white)
             }
             .buttonStyle(ColorfulButtonStyle())
         }
     }
 }
 

struct EmbossedButton_Previews: PreviewProvider {
    static var previews: some View {
        EmbossedButton(systemName: "arrow.fill", action: {})
    }
}
