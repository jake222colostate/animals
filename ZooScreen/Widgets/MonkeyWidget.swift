import WidgetKit
import SwiftUI

struct MonkeyWidgetEntry: TimelineEntry {
    let date: Date
    let action: String
}

struct MonkeyWidgetProvider: TimelineProvider {
    func placeholder(in context: Context) -> MonkeyWidgetEntry {
        MonkeyWidgetEntry(date: Date(), action: "swinging")
    }

    func getSnapshot(in context: Context, completion: @escaping (MonkeyWidgetEntry) -> ()) {
        completion(MonkeyWidgetEntry(date: Date(), action: "swinging"))
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<MonkeyWidgetEntry>) -> ()) {
        let entry = MonkeyWidgetEntry(date: Date(), action: ["swinging", "napping", "eating"].randomElement()!)
        let timeline = Timeline(entries: [entry], policy: .after(Date().addingTimeInterval(10)))
        completion(timeline)
    }
}

struct MonkeyWidgetEntryView: View {
    var entry: MonkeyWidgetProvider.Entry

    var body: some View {
        VStack {
            Text("🐵")
            Text(entry.action)
        }
    }
}

struct MonkeyWidget: Widget {
    let kind: String = "MonkeyWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: MonkeyWidgetProvider()) { entry in
            MonkeyWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Monkey Activity")
        .description("Shows the monkey's current action.")
        .supportedFamilies([.systemSmall])
    }
}

@main
struct MonkeyWidgetBundle: WidgetBundle {
    var body: some Widget {
        MonkeyWidget()
    }
}
