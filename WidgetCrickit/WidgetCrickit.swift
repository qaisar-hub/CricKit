//
//  WidgetCrickit.swift
//  WidgetCrickit
//
//  Created by  Ephrim Daniel J on 04/09/23.
//
import WidgetKit
import SwiftUI
import Intents
import AppIntents

// MARK: widget configuration
@available(iOS 17.0, *)
struct CrickitWidget: Widget {
    let kind: String = "CrickitWidget"
    
    var body: some WidgetConfiguration {
        AppIntentConfiguration(
            kind: kind,
            intent: LiveScoreIntent.self,
            provider: Provider()
        )
        { entry in
            CrickitWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Crickit Live Score widget") //disaplyed on configurable option
        .description("Live score widget") //disaplyed on configurable option
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

@available(iOS 17.0, *)
struct Provider: AppIntentTimelineProvider {
    
    // the timeline which updates the widget based on the chosen configuration value
    func timeline(for configuration: LiveScoreIntent, in context: Context) async -> Timeline<LiveScoreCardEntry> {
        var liveScoreCardModel : LiveScoreCardModel!
        let result = try! await GetLiveScoreForIntent.liveScore(configureFirebase: true)
        for (index, item) in result.enumerated() {
            // matches the current cnfiguration value from the results and updates the widget view
            if (configuration.matchName.id.entityIdentifierString == item.matchHeader ) {
                liveScoreCardModel = result[index]
            }
        }
        let entry = LiveScoreCardEntry(date: .now, liveScoreCardModel: liveScoreCardModel)
        let currentDate = Date()
        let refreshRate = Calendar.current.date(byAdding: .second, value: 1, to: currentDate)!
        return Timeline(
            entries: [entry],
            policy: .after(refreshRate)
        )
    }
    
    func snapshot(for configuration: LiveScoreIntent, in context: Context) async -> LiveScoreCardEntry {
        return LiveScoreCardEntry(date: .now, liveScoreCardModel: LiveScoreCardEntry.mockLiveScoreCardEntry())
    }
    
    // shows mock entry while adding the widget
    func placeholder(in context: Context) -> LiveScoreCardEntry {
        return LiveScoreCardEntry(date: .now, liveScoreCardModel: LiveScoreCardEntry.mockLiveScoreCardEntry())
    }
}


// MARK: Configurable Widget
@available(iOS 17.0, *)
// Confgiration Inetent to get the value configure widget option
struct LiveScoreIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "dddd"
    static var description: IntentDescription = IntentDescription("ccccc")
    
    @Parameter(title: "MatchName")
    var matchName: LiveScoreAppEntity
}

@available(iOS 17.0, *)
struct LiveScoreAppEntity: AppEntity{
    
    var id: String
    static var typeDisplayRepresentation: TypeDisplayRepresentation = "match name"

    var displayRepresentation: DisplayRepresentation {
        DisplayRepresentation(title: "\(id)")
    }

    static var defaultQuery = LiveScoreQuery()
    
    // fetches all the live score matches as entries which is used to display as a list in configure widget view
    static func getLiveScoreCardEntries() async -> [LiveScoreAppEntity] {
        var allMatches = [LiveScoreAppEntity]()
        allMatches.removeAll()
        do {
            let result = try await GetLiveScoreForIntent.liveScore()
            for item in result {
                let entity = LiveScoreAppEntity(id: item.matchHeader)
                allMatches.append(entity)
            }
        }  catch {
            print(error)
        }
        return allMatches
    }
}

struct LiveScoreQuery: EntityQuery, DynamicOptionsProvider {

    // Fetches the chosen id
    func entities(for identifiers: [LiveScoreAppEntity.ID]) async throws -> [LiveScoreAppEntity] {
        await LiveScoreAppEntity.getLiveScoreCardEntries().filter {
            identifiers.contains($0.id)
        }
    }

    // lists suggested entries
    func suggestedEntities() async throws -> [LiveScoreAppEntity] {
        let entity = await LiveScoreAppEntity.getLiveScoreCardEntries()
        print("<<< suggestedEntities \(entity)")
        return entity
    }
    
    // this helps in displaying the widget for the first time with default value
    func defaultResult() async -> LiveScoreAppEntity? {
        let entity = await LiveScoreAppEntity.getLiveScoreCardEntries().first
        return entity
    }

}


// MARK: CrickitWidgetEntryView for our widget
// decides the widget on whether to show small or medium
struct CrickitWidgetEntryView : View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var family

    @ViewBuilder
    var body: some View {
        switch family {
        case .systemSmall:
            WidgetSmall(_liveScorecardModel: entry.liveScoreCardModel)
            
        case .systemMedium:
            WidgetMedium(_liveScorecardModel: entry.liveScoreCardModel)

        @unknown default:
            WidgetSmall(_liveScorecardModel: entry.liveScoreCardModel)
        }
    }
}





