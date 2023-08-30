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
    var body: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "chevron.left")
                .font(.footnote)
                .padding(.vertical, 8)
                .padding(.horizontal, 12)
                .background(appSettings.isDarkMode ? Color.linearBlackColor : Color.linearWhiteColor)
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(color: Color.black, radius: 5)
        }
    }
}

struct CustomBackButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomBackButton()
    }
}
