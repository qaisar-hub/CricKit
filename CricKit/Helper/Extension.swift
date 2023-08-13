//
//  RoundView.swift
//  PlayerProfileCrickit
//
//  Created by qaisar.raza on 26/07/23.
//

import SwiftUI

extension UIView {
    func round() {
        let size = CGSize(width: 10, height: 10)
        let bezierPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.allCorners], cornerRadii: size)
        let shaperLayer = CAShapeLayer()
        shaperLayer.frame = self.bounds
        shaperLayer.path = bezierPath.cgPath
        self.layer.mask = shaperLayer
    }
}

extension Color {
	static let appSecondary = Color(#colorLiteral(red: 0.992, green: 0.757, blue: 0.055, alpha: 1)) // #fdc10e
	//static let appSecondary = Color(#colorLiteral(red: 0.769, green: 0.588, blue: 0.318, alpha: 1)) // #c49651
    static let appPrimary = Color(red: 0.882, green: 0.831, blue: 0.788) // #e1d4c9
    static let appBlacks = Color(red: 0.125, green: 0.137, blue: 0.145) // #202325
    static let appWhites = Color(red: 0.902, green: 0.906, blue: 0.91) // #e6e7e8
    static let linearColor = LinearGradient(colors: [Color.appSecondary, Color.appPrimary, Color.appSecondary], startPoint: .topLeading, endPoint: .bottomTrailing)
}
