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
    @State private var isTapped = false
    @State private var showingAlert = false
    @State private var alert: AlertTypes? = nil
    
    var body: some View {
        VStack() {
            Text("Please fill the details and create account.")
                .padding(.bottom, 16)
                .fontWidth(.expanded)
                .font(.system(size: 12))
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
                    withAnimation {
                        isTapped.toggle()
                    }
                    Task {
                        try await authViewModel.createUser(withEmail: progress.emailId
                                                           ,password: progress.password, fullName: progress.fullName)
                        isLoading = false // stop loading indicator
                        alert = authViewModel.checkUserStatus()
                        if alert != nil {
                            withAnimation {
                                isTapped.toggle()
                            }
                        }
                    }
                } label: {
                    HStack(spacing: 5) {
                        if isTapped {
                            Text(isLoading ? "Signing Up" : "Sign Up")
                                .fontWeight(.medium)
                                .padding(.leading, 10)
                        }
                        Image(systemName: "arrow.right")
                            .frame(width: 40, height: 40)
                            .foregroundColor(.blue)
                            .background(Color.appBlacks)
                            .clipShape(Circle())
                        
                        if !isTapped {
                            Text(isLoading ? "Signing Up" : "Sign Up")
                                .fontWeight(.medium)
                                .padding(.trailing, 10)
                        }
                        
                    }
                    .padding(2)
                    .background(.white)
                    .clipShape(Capsule())
                    .padding(.trailing, 10)
                }
            }
        }
        .cornerRadius(20, corners: [ .bottomLeft, .topLeft])
        .padding(.bottom)
        .alert(item: $alert) { value in
            return value.alert
        }
        
    }
}


struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(isLoading: .constant(false))
            .environmentObject(AuthViewModel())
    }
}
