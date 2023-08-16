//
//  Provider.swift
//  CricKit
//
//  Created by  Ephrim Daniel J on 16/08/23.
//

import Foundation
import WidgetKit


struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> LiveScoreCardEntry {
        LiveScoreCardEntry(date: Date(), configuration: ConfigurationIntent(), liveScoreCard: LiveScoreCardEntry.mockLiveScoreCardEntry())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (LiveScoreCardEntry) -> ()) {
        let entry = LiveScoreCardEntry(date: Date(), configuration: configuration, liveScoreCard: LiveScoreCardEntry.mockLiveScoreCardEntry())
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<LiveScoreCardEntry>) -> ()) {
        var entries: [LiveScoreCardEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = LiveScoreCardEntry(date: entryDate, configuration: configuration, liveScoreCard: LiveScoreCardEntry.mockLiveScoreCardEntry())
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}
