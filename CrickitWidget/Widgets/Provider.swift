//
//  Provider.swift
//  CricKit
//
//  Created by  Ephrim Daniel J on 16/08/23.
//

import Foundation
import WidgetKit
import Firebase


struct Provider: IntentTimelineProvider {
    
    
    func placeholder(in context: Context) -> LiveScoreCardEntry {
        LiveScoreCardEntry(date: Date(), configuration: ConfigurationIntent(), liveScoreCardModel: LiveScoreCardEntry.mockLiveScoreCardEntry())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (LiveScoreCardEntry) -> ()) {
        let entry = LiveScoreCardEntry(date: Date(), configuration: configuration, liveScoreCardModel: LiveScoreCardEntry.mockLiveScoreCardEntry())
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<LiveScoreCardEntry>) -> Void)  {
        print("<<< called widget")
        LiveScoreCardViewModel.shared.getLiveScoreForWidget { result in
            let liveScoreModel: LiveScoreCardModel = result[0]
            let currentDate = Date()
            let entry = LiveScoreCardEntry(date: currentDate, configuration: configuration, liveScoreCardModel: liveScoreModel)
            let refreshRate = Calendar.current.date(byAdding: .second, value: 10, to: currentDate)!
            print("<<< updated")
            let timeline = Timeline(entries: [entry], policy: .after(refreshRate))
            completion(timeline)
        }
        
        

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
//        let currentDate = Date()
//        for hourOffset in 0 ..< 5 {
//            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
//            let entry = LiveScoreCardEntry(date: entryDate, configuration: configuration, liveScoreCardModel: LiveScoreCardEntry.mockLiveScoreCardEntry())
//            entries.append(entry)
//        }
//
//        let timeline = Timeline(entries: entries, policy: .atEnd)
        
    }
}
