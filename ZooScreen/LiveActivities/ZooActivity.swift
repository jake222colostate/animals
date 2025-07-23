import ActivityKit
import SwiftUI

struct ZooActivityAttributes: ActivityAttributes {
    struct AnimalInfo: Codable, Hashable {
        var icon: String
        var action: String
    }
    public struct ContentState: Codable, Hashable {
        var animals: [AnimalInfo]
    }
}

struct ZooLiveActivityView: View {
    let context: ActivityViewContext<ZooActivityAttributes>

    var body: some View {
        HStack {
            ForEach(context.state.animals.prefix(3), id: \.self) { info in
                VStack {
                    Text(info.icon)
                    Text(info.action)
                }
                .padding(4)
            }
        }
        .padding()
    }
}
