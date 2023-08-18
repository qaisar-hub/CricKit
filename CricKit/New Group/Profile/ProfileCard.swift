//
//  ProfileCard.swift
//  CricKit
//
//  Created by Qaisar Raza on 18/08/23.
//

import SwiftUI

struct ProfileCard: View {
    var initials: String
    var fullName: String
    var emailID: String
    
    var body: some View {
        HStack {
            if let userImage = UIImage(named: "userImage") {
                Image(uiImage: userImage)
                    .resizable()
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                    .shadow(radius: 5)
            } else {
                Text(initials)
                    .frame(width: 60, height: 60)
                    .background(Color(.systemGray3))
                    .clipShape(Circle())
                    .shadow(radius: 5)
            }
            
            VStack(alignment: .leading) {
                Text(fullName)
                    .font(.title)
                Text(emailID)
                    .foregroundColor(Color.appPrimary)
            }
        }
    }
}

struct ProfileCard_Previews: PreviewProvider {
    static var previews: some View {
        ProfileCard(initials: "VK", fullName: "Virat Kohli", emailID: "virat_k@gmail.com")
    }
}
