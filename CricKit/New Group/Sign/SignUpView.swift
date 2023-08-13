//
//  signUpView.swift
//  Crickit_iOSAthon
//
//  Created by ephrim.daniel on 26/07/23.
//

import SwiftUI

struct SignUpView: View {
    
    @State private var readyToNavigate = false
    @StateObject var progress = TextFieldObserver()
    
    
    var body: some View {
        VStack() {
            Text("SIGN UP")
                .padding()
                .fontWidth(.expanded)
                .font(.system(size: 25))
                .fontWeight(.bold)
                .foregroundStyle(
                    .linearGradient(colors: [Color.appSecondary, Color.appPrimary, Color.appSecondary], startPoint: .topLeading, endPoint: .bottomTrailing)
                )
            customTextField(placeholderText: "Email ID", spacing: 0.0, textValue: $progress.upcTextValue)
            
            customTextField(placeholderText: "New Password", spacing: 0.0, textValue: $progress.upcTextValue)
                
            customTextField(placeholderText: "Confirm Password", spacing: 0.0, textValue: $progress.upcTextValue)
                
            HStack {
                Spacer()
                Button {
                    readyToNavigate = true
                } label: {
                    Image(systemName: "arrow.right")
                        .frame(width: 50, height: 50)
                        .foregroundColor(Color.appSecondary)
                        .background(Color.appBlacks)
                        .clipShape(Circle())
                        .padding()
                }
            }
        }
        .cornerRadius(20, corners: [ .bottomLeft, .topLeft])
        .padding(.bottom)
    }
}


struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
