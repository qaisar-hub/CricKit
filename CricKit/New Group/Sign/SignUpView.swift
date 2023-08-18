//
//  signUpView.swift
//  CricKit
//
//  Created by ephrim.daniel on 26/07/23.
//

import SwiftUI

struct SignUpView: View {
    
    @State private var readyToNavigate = false
    @StateObject var progress = TextFieldObserver()
    @EnvironmentObject var authViewModel: AuthViewModel
    @Binding var isLoading: Bool
    
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
            customTextField(placeholderText: "Full Name", spacing: 0.0, textValue: $progress.fullName)
            
            customTextField(placeholderText: "Email ID", spacing: 0.0, textValue: $progress.emailId)
            
            customTextField(placeholderText: "New Password", spacing: 0.0, textValue: $progress.password)
            
            customTextField(placeholderText: "Confirm Password", spacing: 0.0, textValue: $progress.confirmPassword)
            
            
            HStack {
                Spacer()
                Button {
                    isLoading = true // start loading indicator
                    
                    Task {
                        try await authViewModel.createUser(withEmail: progress.emailId
                                                           ,password: progress.password, fullName: progress.fullName)
                        
                        isLoading = false // stop loading indicator
                    }
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
        SignUpView(isLoading: .constant(false))
            .environmentObject(AuthViewModel())
    }
}
