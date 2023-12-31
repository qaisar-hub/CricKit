//
//  SettingsRowView.swift
//  CricKit
//
//  Created by Qaisar Raza on 18/08/23.
//

import SwiftUI

struct SettingsRowView: View {
    let iconName: String
    let title: String
    let subtitle: String
    let tintColor: Color
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: iconName)
                .imageScale(.small)
                .font(.title)
                .foregroundColor(tintColor)
            
            
            Text(title)
                .foregroundColor(tintColor)
            Spacer()
            Text(subtitle)
                .font(.subheadline)
                .foregroundColor(tintColor)
        }
    }
}

struct SettingsRowView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsRowView(iconName: "gear", title: "Version", subtitle: "1.0.0", tintColor: .gray)
    }
}
