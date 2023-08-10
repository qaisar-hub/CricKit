//
//  customTextField.swift
//  kmm
//
//  Created by ephrim.daniel on 23/11/22.
//

import SwiftUI

struct customTextField: View {
    var placeholderText: String
    var spacing: CGFloat
    @Binding var textValue: String
    
    var body: some View {
        VStack(spacing: 0) {
            TextField("", text: self.$textValue)
                .padding(4)
                .accentColor(Color.appSecondary)
                .fontWidth(.expanded)
                .font(.system(size: 12))
                .modifier(PlaceholderStyle(showPlaceHolder: textValue.isEmpty,
                                       placeholder: placeholderText))
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.appSecondary, lineWidth: 2)
                        .background(Color.appBlacks)
                )
                .padding()
        }
    }
}


class TextFieldAlert: ObservableObject {
    @Published var show = false
    @Published var value : String = ""
}

public struct PlaceholderStyle: ViewModifier {
    var showPlaceHolder: Bool
    var placeholder: String

    public func body(content: Content) -> some View {
        ZStack(alignment: .leading) {
            if showPlaceHolder {
                Text(placeholder)
                .padding(.horizontal, 5)
                .foregroundStyle(
                    .linearGradient(colors: [Color.appSecondary, Color.appPrimary, Color.appSecondary], startPoint: .topLeading, endPoint: .bottomTrailing)
                )
                .opacity(0.5)
            }
            content
                .foregroundStyle(
                    .linearGradient(colors: [Color.appSecondary, Color.appPrimary, Color.appSecondary], startPoint: .topLeading, endPoint: .bottomTrailing)
                )
            .padding(5.0)
        }
    }
}

