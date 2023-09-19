//
//  SectionTitleView.swift
//  CricKit
//
//  Created by  Ephrim Daniel J on 16/08/23.
//

import SwiftUI

struct SectionTitleView: View {
	@EnvironmentObject private var appSettings: AppSettings
	
    let title: String
    var body: some View {
        Text(title)
			.foregroundColor(appSettings.isDarkMode ? Color.white : Color.black)
            .padding(10)
            .font(.footnote)
			.background(BlurManagerData.blurMaterial(colorScheme: appSettings.isDarkMode ? .dark : .light))
            .cornerRadius(20, corners: .allCorners)
			.shadow(color: appSettings.isDarkMode ? Color.black : Color.white, radius: 0.5)
    }
}
