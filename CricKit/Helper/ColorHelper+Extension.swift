//
//  RoundView.swift
//  PlayerProfileCrickit
//
//  Created by qaisar.raza on 26/07/23.
//

import SwiftUI

public class ColorManager {
    static func appTextColor(colorScheme: ColorScheme) -> Color{
        var textColor: Color {
            switch colorScheme {
            case .light:
                return Color(.black)
            case .dark:
                return Color(.white)
            @unknown default:
                return Color(.black)
            }
        }
        return textColor
    }
    
    static func appPrimaryColor() -> Color{
        var primaryColor: Color {
            return Color(#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1))
        }
        return primaryColor
    }
    
    static func appSecondary(colorScheme: ColorScheme) -> Color{
        var appSecondaryColor: Color {
            switch colorScheme {
            case .light:
                return Color(.white)
            case .dark:
                return  Color(#colorLiteral(red: 0.03084787726, green: 0.0898687616, blue: 0.1246017292, alpha: 1))
            @unknown default:
                return Color(.white)
            }
        }
        return appSecondaryColor
    }
}

public class BlurManagerData {
    static func blurMaterial(colorScheme: ColorScheme) -> Blur {
        var style: UIBlurEffect.Style = .systemMaterial
        
        switch colorScheme {
        case .light:
            style = .extraLight
        case .dark:
            style = .systemChromeMaterialDark
        @unknown default:
            style = .extraLight
        }
        
        return Blur(style: style)
    }
}

struct Blur: UIViewRepresentable {
    var style: UIBlurEffect.Style = .systemMaterial
    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}


extension Color {
    static let appSecondary = Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)) // #c49651
    static let appPrimary = Color(#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1))
    static let appBlacks = Color(#colorLiteral(red: 0.03084787726, green: 0.0898687616, blue: 0.1246017292, alpha: 1))
    static let appWhites = Color(red: 0.902, green: 0.906, blue: 0.91) // #e6e7e8
	static let linearWhiteColor = LinearGradient(colors: [Color.appPrimary.opacity(0.8),Color.appWhites], startPoint: .topLeading, endPoint: .bottomTrailing)
    static let linearBlackColor = LinearGradient(colors: [Color.appPrimary,Color.appBlacks.opacity(0.8)], startPoint: .topLeading, endPoint: .bottomTrailing)
}
