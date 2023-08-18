//
//  ContentView.swift
//  PlayerProfileCrickit
//
//  Created by qaisar.raza on 26/07/23.
//

import SwiftUI

struct PlayerProfileView: View {
    
    let playerImage: String
    let playerTeamName: String
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.appBlacks
                    .clipShape(BackgroundCard())
                PlayerBackgroundView(imageName: playerImage)
                                .offset(x: 120.0)
               
                VStack {
                    Spacer()
                    HStack {
                        Text("MS DHONI ")
                            .font(.system(size: 70))
                            .foregroundStyle(
                              Color.appWhites)
                            .fontWeight(.heavy)
                            .rotationEffect(.degrees(-90))
                       Spacer()
                    }.offset(x: UIScreen.main.bounds.minX - 100)
                    Spacer()
                    HStack {
                        PlayerStatsView()
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    CustomBackButton()
                }
            })
            .ignoresSafeArea()
        }
    }
}

struct CustomBackButton: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "chevron.left")
                .font(.footnote)
                .padding(.vertical, 8)
                .padding(.horizontal, 12)
                .background(Color.linearColor)
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(color: Color.black, radius: 5)
        }
    }
}

struct PlayerProfileView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerProfileView(playerImage: "pp_dhoni", playerTeamName: "INDIA")
    }
}
