//
//  CrickitWidget.swift
//  CrickitWidget
//
//  Created by  Ephrim Daniel J on 16/08/23.
//

import WidgetKit
import SwiftUI
import Intents

struct CrickitWidgetEntryView : View {
    
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var family

    @ViewBuilder
    var body: some View {
        switch family {
        case .systemSmall:
            WidgetSmall(_liveScorecard: entry.liveScoreCard)
            
        case .systemMedium:
            WidgetMedium(_liveScorecard: entry.liveScoreCard)

        @unknown default:
            WidgetSmall(_liveScorecard: entry.liveScoreCard)
        }
    }
}

struct CrickitWidget: Widget {
    let kind: String = "CrickitWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            CrickitWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

struct CrickitWidget_Previews: PreviewProvider {
    static var previews: some View {
        CrickitWidgetEntryView(entry: LiveScoreCardEntry(date: Date(), configuration: ConfigurationIntent(), liveScoreCard: LiveScoreCardEntry.mockLiveScoreCardEntry()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
