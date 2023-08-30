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
    var isSecureField: Bool = false
	
	var body: some View {
		VStack(spacing: 0) {
            if isSecureField {
                SecureTextFieldWithToggle(textValue: $textValue, placeholderText: placeholderText)
            } else {
                TextField("", text: self.$textValue)
                    .padding(4)
                    .accentColor(Color.white)
                    .font(.system(size: 20))
                    .foregroundColor(.white)
                    .modifier(TextFieldModifier(placeholder: placeholderText, showPlaceHolder: textValue.isEmpty))
                    .padding()
            }
		}
	}
}

struct SecureTextFieldWithToggle: View {
    @Binding var textValue: String
    var placeholderText: String
    @State private var isSecure: Bool = true
    @StateObject var progress = TextFieldObserver()
    
    var body: some View {
            HStack {
                if isSecure {
                    SecureField("", text: self.$textValue)
                        .padding(4)
                        .accentColor(Color.white)
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                        .modifier(TextFieldModifier(placeholder: placeholderText, showPlaceHolder: textValue.isEmpty))
                        .padding()
                } else {
                    TextField("", text: self.$textValue)
                        .padding(4)
                        .accentColor(Color.white)
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                        .modifier(TextFieldModifier(placeholder: placeholderText, showPlaceHolder: textValue.isEmpty))
                        .padding()
                }
                
                Button(action: {
                    isSecure.toggle()
                }) {
                    Image(systemName: isSecure ? "eye.slash.fill" : "eye.fill")
                        .foregroundColor(.gray)
                }
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
					.foregroundColor(.appWhites)
					.opacity(0.8)
			}
			content
				.foregroundColor(.white)
				.padding(5.0)
		}
	}
}


struct TextFieldModifier: ViewModifier {
	var placeholder: String
	var showPlaceHolder: Bool
	
	func body (content: Content) -> some View {
		
		ZStack(alignment: .leading) {
			
			if showPlaceHolder {
				Text(placeholder)
					.padding(.horizontal, 5)
					.foregroundColor(.appWhites)
					.opacity(0.5)
			}
			content
				.overlay (
					RoundedRectangle (cornerRadius: 15)
						.stroke(Color.darkStart.opacity(0.1), lineWidth: 0.3)
						.shadow(color: Color.darkStart.opacity(0.2), radius: 0.8, x: 1, y: 1)
						.clipShape (RoundedRectangle (cornerRadius: 15))
						.shadow(color: Color.darkStart.opacity(0.2), radius: 0.8, x: -1, y: -1)
						.clipShape (RoundedRectangle (cornerRadius: 15))
				)
		}
	}
}

