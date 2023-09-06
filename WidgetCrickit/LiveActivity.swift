//
//  LiveActivityWidget.swift
//  WidgetCrickitExtension
//
//  Created by  Ephrim Daniel J on 05/09/23.
//

import Foundation
import ActivityKit

struct LiveScoreActivityAttributes: ActivityAttributes {
    
    public typealias TimeStatus = ContentState
    
    public struct ContentState: Codable, Hashable{
        var matchStatus: String
    }
    
    var matchName: String
}


@main

