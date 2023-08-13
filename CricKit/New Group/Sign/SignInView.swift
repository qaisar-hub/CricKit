//
//  signInView.swift
//  Crickit_iOSAthon
//
//  Created by ephrim.daniel on 26/07/23.
//

import SwiftUI

struct SignInView: View {
    
    //@State private var readyToNavigate = false
    @Binding var readyToNavigate: Bool
    
    @StateObject var progress = TextFieldObserver()
    
    
    var body: some View {
        VStack {
            Text("SIGN IN")
                .padding()
                .fontWidth(.expanded)
                .font(.system(size: 25))
                .fontWeight(.bold)
                .foregroundStyle(
                    .linearGradient(colors: [Color.appSecondary, Color.appPrimary, Color.appSecondary], startPoint: .topLeading, endPoint: .bottomTrailing)
                )
            customTextField(placeholderText: "UserName", spacing: 0.0, textValue: $progress.upcTextValue)
            
            
            customTextField(placeholderText: "Password", spacing: 0.0, textValue: $progress.sheetTextValue)
            
            
            Text("Forgot Password ?")
                .padding()
                .fontWidth(.expanded)
                .font(.system(size: 12))
                .foregroundStyle(
                    .linearGradient(colors: [Color.appSecondary, Color.appPrimary, Color.appSecondary], startPoint: .topLeading, endPoint: .bottomTrailing)
                )
            
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
    }
}
