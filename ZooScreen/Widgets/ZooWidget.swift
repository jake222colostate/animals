import WidgetKit
import SwiftUI

struct ZooWidgetEntry: TimelineEntry {
    let date: Date
    let animals: [ZooActivityAttributes.AnimalInfo]
}

struct ZooWidgetProvider: TimelineProvider {
    func placeholder(in context: Context) -> ZooWidgetEntry {
        ZooWidgetEntry(date: Date(), animals: [ZooActivityAttributes.AnimalInfo(icon: "🐶", action: "playing")])
    }

    func getSnapshot(in context: Context, completion: @escaping (ZooWidgetEntry) -> ()) {
        completion(placeholder(in: context))
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<ZooWidgetEntry>) -> ()) {
        let data = UserDefaults.standard.data(forKey: "ZooManager.animals")
        let animals = (try? JSONDecoder().decode([Animal].self, from: data ?? Data())) ?? []
        let infos = animals.prefix(2).map { ZooActivityAttributes.AnimalInfo(icon: $0.species.icon, action: $0.mood.lowercased()) }
        let entry = ZooWidgetEntry(date: Date(), animals: infos)
        let timeline = Timeline(entries: [entry], policy: .after(Date().addingTimeInterval(300)))
        completion(timeline)
    }
}

struct ZooWidgetEntryView: View {
    var entry: ZooWidgetProvider.Entry

    var body: some View {
        HStack {
            ForEach(entry.animals.prefix(2), id: \.self) { info in
                VStack {
                    Text(info.icon)
                    Text(info.action)
                }
            }
        }
    }
}

struct ZooWidget: Widget {
    let kind: String = "ZooWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: ZooWidgetProvider()) { entry in
            ZooWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Zoo Status")
        .description("Shows your animals at a glance.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

@main
struct ZooWidgetBundle: WidgetBundle {
    var body: some Widget {
        ZooWidget()
    }
}
