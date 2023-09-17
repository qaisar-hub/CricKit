//
//  CustomBackButton.swift
//  CricKit
//
//  Created by Qaisar Raza on 28/08/23.
//

import SwiftUI

struct CustomBackButton: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject private var appSettings: AppSettings
    var liveMode = false
    
    var body: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            if liveMode {
                Text("Close")
                    .font(.headline)
                    .padding(10)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.white, lineWidth: 2)
                    )
            } else {
                Image(systemName: "chevron.left")
                    .font(.headline)
                    .padding(.vertical, 8)
                    .foregroundColor(.blue)
            }
        }
    }
}

struct CustomBackButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomBackButton()
            .environmentObject(AppSettings())
    }
}
