//
//  AppLogoView.swift
//  CricKit
//
//  Created by Qaisar Raza on 09/09/23.
//

import SwiftUI

struct AppLogoView: View {
    var body: some View {
        HStack {
            ZStack{
                Circle()
                    .fill(ColorManager.appPrimaryColor())
                    .frame(width: 30, height: 30)
                Image("batsman")
                    .resizable()
                    .frame(width: 40, height: 40)
            }
            Text("CricKit")
                .fontWidth(.expanded)
                .font(.system(size: 30))
                .fontWeight(.bold)
                .foregroundStyle(ColorManager.appPrimaryColor())
            Spacer()
        }
        .padding()
    }
}

#Preview {
    AppLogoView()
}
