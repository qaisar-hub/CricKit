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
    static let appSecondary = Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)) // #c49651
    static let appPrimary = Color(#colorLiteral(red: 0.2056267262, green: 0.5325312614, blue: 0.7769566178, alpha: 1))
    static let appBlacks = Color(#colorLiteral(red: 0.03084787726, green: 0.0898687616, blue: 0.1246017292, alpha: 1))
    static let appWhites = Color(red: 0.902, green: 0.906, blue: 0.91) // #e6e7e8
	static let linearColor = LinearGradient(colors: [Color.appPrimary,Color.appBlacks], startPoint: .topLeading, endPoint: .bottomTrailing)
}
