//
//  LiveActivity.swift
//  WidgetCrickitExtension
//
//  Created by  Ephrim Daniel J on 05/09/23.
//

import Foundation
import WidgetKit
import ActivityKit
import SwiftUI

struct LiveScoreActivityAttributes: ActivityAttributes {
    
    public struct ContentState: Codable, Hashable{
        var endTime: Date
    }

    var matchName: String
    var matchStatus: String
    
    var leftTeamflag: String
    var leftTeamName: String
    var leftTeamRuns: String
    var leftTeamOvers: String
    var leftTeamWickets: String
    
    var rightTeamflag: String
    var rightTeamName: String
    var rightTeamRuns: String
    var rightTeamOvers: String
    var rightTeamWickets: String
}


struct CrickitLiveActivity: Widget {
    
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: LiveScoreActivityAttributes.self) { context in
            // Lock screen/banner UI goes here
            LiveActivityView(context: context)
            //LiveScoreCardViewForIntent
        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("")
                    // more content
                }
            } compactLeading: {
                Text("")
            } compactTrailing: {
                Text("")
            } minimal: {
                Text("")
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

struct LiveActivityView: View {
    let context: ActivityViewContext<LiveScoreActivityAttributes>
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            Text(context.attributes.matchName)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                .opacity(0.8)
                .padding(.top, 5)
            
            HStack {
                Image(context.attributes.leftTeamflag)
                    .resizable()
                    .frame(width: 35, height: 35)
                HStack(spacing: 5){
                    Text(context.attributes.leftTeamName)
                        .font(.subheadline)
                        .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                    Text(context.attributes.leftTeamRuns.isEmpty ? "" : "\(context.attributes.leftTeamRuns)/\(context.attributes.leftTeamWickets)")
                        .font(.subheadline)
                        .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                    Spacer()
                    Text(context.attributes.leftTeamRuns.isEmpty ? "Yet to Bat" :"\(context.attributes.leftTeamOvers) overs")
                        .font(.subheadline)
                        .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                }
            }
            .padding(.leading, 5)
            .padding(.trailing, 5)
            
            HStack {
                Image(context.attributes.rightTeamflag)
                    .resizable()
                    .frame(width: 35, height: 35)
                HStack(spacing: 5){
                    Text(context.attributes.rightTeamName)
                        .font(.subheadline)
                        .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                    Text(context.attributes.rightTeamRuns.isEmpty ? "" : "\(context.attributes.rightTeamRuns)/\(context.attributes.rightTeamWickets)")
                        .font(.subheadline)
                        .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                    Spacer()
                    Text(context.attributes.rightTeamRuns.isEmpty ? "Yet to Bat" : "\(context.attributes.rightTeamOvers) overs")
                        .font(.subheadline)
                        .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                }
            }
            .padding(.leading, 5)
            .padding(.trailing, 5)
            
            Text(context.attributes.matchStatus)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                .opacity(0.8)
                .padding(.bottom, 5)
        }
    }
}

