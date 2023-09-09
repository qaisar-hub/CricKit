//
//  NewsModel.swift
//  CricKit
//
//  Created by Qaisar Raza on 09/09/23.
//

import Foundation

struct NewsModel: Identifiable {
    var id = UUID()
    var imageName: String
    var header: String
    var subheader: String
}
