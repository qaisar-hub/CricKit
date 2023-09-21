//
//  ProfileCard.swift
//  CricKit
//
//  Created by Qaisar Raza on 18/08/23.
//

import SwiftUI
import TipKit

struct ProfileCard: View {
    @State var showImagePicker: Bool = false
    @State var showFullScreenImage: Bool = false
    @EnvironmentObject var appSettings: AppSettings
    let onUserImageChange: () -> Void
    
    var initials: String
    var fullName: String
    var emailID: String
    
    var body: some View {
        HStack(spacing: 20) {
            if let image = appSettings.userImage, let userImage = UIImage(data: image)  {
                Image(uiImage: userImage)
                    .resizable()
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                    .shadow(radius: 5)
                    .overlay(
                        CameraImageView(showFullScreenImage: $showFullScreenImage)
                    )
            } else {
                Text(initials)
                    .font(.headline)
                    .foregroundColor(Color.white)
                    .frame(width: 60, height: 60)
                    .background(Color(.systemGray3).opacity(0.5))
                    .clipShape(Circle())
                    .shadow(radius: 5)
                    .overlay(
                        CameraImageView(showFullScreenImage: $showFullScreenImage)
                    )
            }
            
            VStack(alignment: .leading) {
                Text(fullName)
                    .font(.headline)
                    .foregroundColor(ColorManager.appTextColor(colorScheme: appSettings.isDarkMode ? .dark : .light))
                Text(emailID)
                    .foregroundColor(ColorManager.appTextColor(colorScheme: appSettings.isDarkMode ? .dark : .light))
            }
        }
        .fullScreenCover(isPresented: $showFullScreenImage) {
            ProfilePhoto(showImagePicker: $showImagePicker, showFullScreenImage: $showFullScreenImage,  onUserImageChange: onUserImageChange)
                .contentTransition(.opacity)
        }
    }
}

struct CameraImageView: View {
    @Binding var showFullScreenImage: Bool
    var body: some View {
        Image(systemName: "camera")
            .font(.headline)
            .foregroundColor(ColorManager.appPrimaryColor())
            .offset(x: 25, y: 25)
            .onTapGesture {
                withAnimation {
                    showFullScreenImage.toggle()
                }
            }
    }
}

struct ProfileCard_Previews: PreviewProvider {
    static var previews: some View {
        ProfileCard(onUserImageChange: {}, initials: "VK", fullName: "Virat Kohli", emailID: "virat_k@gmail.com")
            .environmentObject(AppSettings())
    }
}
